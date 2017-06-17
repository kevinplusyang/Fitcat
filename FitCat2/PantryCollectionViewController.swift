//
//  PantryCollectionViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/24/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "foodCell"

class PantryCollectionViewController: UICollectionViewController {
    var foodArray: [FoodModel] = []
    var cat: CreateCatModel!
    var amountSelectionView: AmountSelectionView!
    var selectedIndex: IndexPath!
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarView?.backgroundColor = .fitcatGray
        navigationController?.navigationBar.backgroundColor = .fitcatGray
        
        //FIREBASE: Get all cats from firebase database
        if let user = FIRAuth.auth()?.currentUser {
            FIRDatabase.database().reference().child("users").child(user.uid).child("foodCollection").observe(.value, with: { (snapshot) in
                if let valueDictionary = snapshot.value as? NSDictionary {
                    self.foodArray = createFoodArray(foodDictionary: valueDictionary)
                    self.collectionView?.reloadData()
                }
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            FIRDatabase.database().reference().child("users").child(user.uid).child("foodCollection").removeAllObservers()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchForCatFood))

        collectionView?.backgroundColor = .fitcatGray
        // Register cell classes
        self.collectionView!.register(FoodPantryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchForCatFood() {
        let foodMarketVC = FoodMarketViewController()
        navigationController?.pushViewController(foodMarketVC, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return foodArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodPantryCollectionViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 6.0
        cell.foodLabel.text = foodArray[indexPath.row].foodName
        cell.foodLabel.sizeToFit()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let amountSelectionViewFrame = CGRect(x: 0.0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height - (navigationController?.navigationBar.frame.maxY)! + 5.0)
        amountSelectionView = AmountSelectionView(frame: amountSelectionViewFrame)
        layoutAmountSelectionView(amountSelectionView: amountSelectionView)
        
        
        view.addSubview(amountSelectionView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.amountSelectionView.frame.origin.y = (self.navigationController?.navigationBar.frame.maxY)! + 5.0
        })
        
    }
    
    func layoutAmountSelectionView(amountSelectionView: AmountSelectionView) {
        
        //Continue Button
        let logFeedingButton = UIButton()
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        logFeedingButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0 - (navigationController?.navigationBar.frame.maxY)!, width: buttonWidth, height: CGFloat(buttonHeight))
        logFeedingButton.center.x = view.center.x
        logFeedingButton.backgroundColor = .fitcatOrange
        //logFeedingButton.layer.borderWidth = 2.0
        //logFeedingButton.layer.borderColor = UIColor.white.cgColor
        logFeedingButton.layer.cornerRadius = 7
        logFeedingButton.setTitle("Feed \(cat.catName)", for: .normal)
        logFeedingButton.addTarget(self, action: #selector(logFeedingButtonClicked), for: .touchUpInside)
        amountSelectionView.addSubview(logFeedingButton)
        
        //Cancel button
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.sizeToFit()
        cancelButton.frame.origin = CGPoint(x: 20, y: 20)
        amountSelectionView.addSubview(cancelButton)
        
        //Main StackView
        //28% height
        //79% width
        let mainStackViewFrame = CGRect(x: 0.0, y: cancelButton.frame.maxY + 50.0, width: amountSelectionView.bounds.width * 0.79, height: amountSelectionView.bounds.height * 0.23)
        let mainStackView = UIStackView(frame: mainStackViewFrame)
        mainStackView.center.x = amountSelectionView.center.x
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.spacing = 5.0
        
        //catfoodImage
        let catFoodImageView = UIImageView(image: #imageLiteral(resourceName: "catfood1"))
        
        //catFoodLabel
        let catFoodLabel = UILabel()
        catFoodLabel.numberOfLines = 3
        catFoodLabel.textAlignment = .center
        catFoodLabel.text = foodArray[selectedIndex.row].foodName
        catFoodLabel.font = UIFont.systemFont(ofSize: 19)
        catFoodLabel.textColor = .black
        catFoodLabel.sizeToFit()
        
        //innerStackView
        let innerStackViewFrame = CGRect(x: 0.0, y: 0.0, width: amountSelectionView.bounds.width * 0.79, height: 30.0)
        let innerStackView = UIStackView(frame: innerStackViewFrame)
        innerStackView.center.x = amountSelectionView.center.x
        innerStackView.axis = .horizontal
        innerStackView.distribution = .equalSpacing
        innerStackView.alignment = .center
        innerStackView.spacing = 5.0
        
        //wetLabel
        let wetLabel = UIImageView(image: #imageLiteral(resourceName: "wetLabel"))
        
        innerStackView.addArrangedSubview(wetLabel)
        
        
        mainStackView.addArrangedSubview(catFoodImageView)
        mainStackView.addArrangedSubview(catFoodLabel)
        mainStackView.addArrangedSubview(innerStackView)
        mainStackView.setNeedsLayout()
        
        amountSelectionView.addSubview(mainStackView)
        
    }
    
    func logFeedingButtonClicked(sender: UIButton) {
        
    }
    
    func cancelButtonPressed(sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.amountSelectionView.frame.origin.y = self.view.frame.maxY + 5.0
        }) { success in
            self.amountSelectionView.removeFromSuperview()
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
