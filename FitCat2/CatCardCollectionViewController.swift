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

private let reuseIdentifier = "catCell"

class CatCardCollectionViewController: UICollectionViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return userCats.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CatCollectionViewCell
        let currentCat = userCats[indexPath.section]
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 6.0
        cell.catName.text = currentCat.catName
        cell.catName.sizeToFit()
        cell.intakeCaloriesNumberLabel.text = "80"
        cell.caloriesRemainingNumberLabel.text = String(describing: Int(currentCat.catPlan.catCalories!))
        
        let percentCompleted = (Double(cell.intakeCaloriesNumberLabel.text!)! / Double(cell.caloriesRemainingNumberLabel.text!)!)
        
        cell.calorieProgressBar.progress = Float(percentCompleted)
        cell.calorieCircleProgressPercent.text = "\(Int(percentCompleted * 100.0))%"
        cell.calorieCircleProgress.progress = percentCompleted
        
        cell.centerLabels()

        cell.catImageView.image = UIImage(data: currentCat.catPictureData)
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCat = userCats[indexPath.section]
        let catDetailsVC = CatDetailsViewController()
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
