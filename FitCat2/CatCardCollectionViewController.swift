//
//  CatCardCollectionViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 4/3/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos
import FirebaseDatabase
import Firebase
import DZNEmptyDataSet

private let reuseIdentifier = "catCell"

enum CatCardError: Error {
    case failedCreatingCell
}

protocol LogAFeeding {
    func clickedLogAFeeding(section: Int)
}

class CatCardCollectionViewController: UICollectionViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, LogAFeeding {
    
    let userDefaults = UserDefaults.standard
    var userCats: [CreateCatModel] = []
    var userID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCat))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editCells))
        
        //collectionView!.collectionViewLayout = flowLayout
        collectionView?.emptyDataSetSource = self
        collectionView?.emptyDataSetDelegate = self
        collectionView?.backgroundColor = .fitcatGray
        

        // Register cell classes
        self.collectionView!.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarView?.backgroundColor = .fitcatGray
        navigationController?.navigationBar.backgroundColor = .fitcatGray
        
        //FIREBASE: Get all cats from firebase database
        if let user = FIRAuth.auth()?.currentUser {
            FIRDatabase.database().reference().child("users").child(user.uid).child("catCollection").observe(.value, with: { (snapshot) in
                if let valueDictionary = snapshot.value as? NSDictionary {
                    self.userCats = createCatArray(catDictionary: valueDictionary)
                    self.userCats = self.userCats.map({cat in
                        let dateCompare = Calendar.current.compare(cat.catFeeding.currentDate, to: Date(), toGranularity: .day)
                        switch dateCompare {
                        case .orderedSame:
                            return cat
                        case .orderedAscending:
                            print("SETTING NEW DATE")
                            cat.catFeeding.currentDate = Date()
                            cat.catFeeding.caloriesToday = 0.0
                            return cat
                        case .orderedDescending:
                            return cat
                        }
                    })
                    self.collectionView?.reloadData()
                }
            })
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            FIRDatabase.database().reference().child("users").child(user.uid).child("catCollection").removeAllObservers()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewCat() {
        let vc = CreateCatViewController()
        let modalNav = UINavigationController(rootViewController: vc)
        let backImage = UIImage(named: "backBtn")
        modalNav.navigationBar.backIndicatorImage = backImage
        modalNav.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        present(modalNav, animated: true, completion: {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 240/255, green: 97/255, blue: 68/255, alpha: 1.0)
        })
    }
    
    func editCells() {
        
    }
    
    func clickedLogAFeeding(section: Int) {
        let selectedCat = userCats[section]
        let catDetailsVC = CatDetailsViewController(goToFeeding: true)
        catDetailsVC.currentCat = selectedCat
        navigationController?.pushViewController(catDetailsVC, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return userCats.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CatCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentCat = userCats[indexPath.section]
        cell.delegate = self
        cell.section = indexPath.section
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 6.0
        cell.catName.text = currentCat.catName
        cell.catName.sizeToFit()
        cell.intakeCaloriesNumberLabel.text = "\(Int(currentCat.catFeeding.caloriesToday))"
        cell.caloriesRemainingNumberLabel.text = String(describing: abs(Int(currentCat.catFeeding.caloriesTotal - currentCat.catFeeding.caloriesToday)))
        
        cell.calorieProgressBar.progress = Float((currentCat.catFeeding.caloriesToday) / currentCat.catFeeding.caloriesTotal)
        cell.calorieCircleProgressPercent.text = "\(Int((abs(Float((currentCat.catFeeding.caloriesToday) / currentCat.catFeeding.caloriesTotal))) * 100.0))%"
        cell.calorieCircleProgress.progress = ((currentCat.catFeeding.caloriesToday) / currentCat.catFeeding.caloriesTotal)
        cell.calorieCircleProgress.progressColors = [.fitcatProgressGreen]
        cell.caloriesRemainingLabel.text = "Calories Remaining"
        cell.caloriesRemainingLabel.sizeToFit()
        cell.calorieProgressBar.progressTintColor = .fitcatProgressGreen
        
        if currentCat.catFeeding.caloriesToday > currentCat.catFeeding.caloriesTotal {
            cell.calorieProgressBar.progressTintColor = .fitcatOrange
            cell.caloriesRemainingLabel.text = "Calories Over"
            cell.caloriesRemainingLabel.sizeToFit()
            cell.calorieCircleProgress.progressColors = [.fitcatOrange]
        }
        
        cell.centerLabels()

        cell.catImageView.image = UIImage(data: currentCat.catPictureData)
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCat = userCats[indexPath.section]
        let catDetailsVC = CatDetailsViewController(goToFeeding: false)
        catDetailsVC.currentCat = selectedCat
        navigationController?.pushViewController(catDetailsVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cardheader", for: indexPath)
        //headerView.frame.size.height = 50
        //headerReferenceSize =  100
        
        return headerView
    }

    
    
    // MARK: DZNEMPTYSET DELEGATE
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100.0
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let titleString = "No Cats Yet"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline), NSForegroundColorAttributeName: UIColor.white]
        return NSAttributedString(string: titleString, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let descriptionString = "Add your first cat to get started!"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body), NSForegroundColorAttributeName: UIColor.white]
        return NSAttributedString(string: descriptionString, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "catIcon")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        let buttonString = "Add A Cat"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .callout), NSForegroundColorAttributeName: UIColor.white]
        return NSAttributedString(string: buttonString, attributes: attrs)
    }
    
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> UIImage? {
        return #imageLiteral(resourceName: "rectangle2")
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 20.0
    }
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        let vc = CreateCatViewController()
        let modalNav = UINavigationController(rootViewController: vc)
        let backImage = UIImage(named: "backBtn")
        modalNav.navigationBar.backIndicatorImage = backImage
        modalNav.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        present(modalNav, animated: true, completion: {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 240/255, green: 97/255, blue: 68/255, alpha: 1.0)
        })
    }


}
