//
//  PantryCollectionViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/24/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit
import Firebase
import PinLayout

private let reuseIdentifier = "foodCell"

class PantryCollectionViewController: UICollectionViewController {
    var foodArray: [FoodModel] = []
    var cat: CreateCatModel!
    var amountSelectionView: AmountSelectionView!
    var selectedIndex: IndexPath!
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarView?.backgroundColor = .fitcatGray
        navigationController?.navigationBar.backgroundColor = .fitcatGray
        
        //FIREBASE: Get user food from firebase database
        if let user = FIRAuth.auth()?.currentUser {
            FIRDatabase.database().reference().child("users").child(user.uid).child("foodCollection").observe(.value, with: { (snapshot) in
                if let valueDictionary = snapshot.value as? NSDictionary {
                    print(valueDictionary)
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
        collectionView?.reloadData()
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
        print(foodArray.count, "COUNT")
        return foodArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FoodPantryCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 6.0
        

//        if foodArray[indexPath.row].style == "wet" {
//            foodImageView.frame = CGRect(x: cell.bounds.width * 0.20, y: 5.0, width: cell.bounds.width * 0.60, height: cell.bounds.height * 0.50)
//            foodImageView.center.x = cell.center.x
//            foodImageView.setNeedsDisplay()
//        }
        cell.addLabel(text: foodArray[indexPath.row].foodName)
        let photoData = UIImagePNGRepresentation(foodArray[indexPath.row].image)
        cell.addImage(image: UIImage(data: photoData!, scale: 1.0)!, isWet: foodArray[indexPath.row].style == "wet")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let amountSelectionViewFrame = CGRect(x: 0.0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height - (navigationController?.navigationBar.frame.maxY)! + 5.0)
        amountSelectionView = AmountSelectionView(frame: amountSelectionViewFrame, foodArray: foodArray, selectedIndex: selectedIndex, currentCat: cat)
        
        view.addSubview(amountSelectionView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.amountSelectionView.frame.origin.y = (self.navigationController?.navigationBar.frame.maxY)! + 5.0
        })
        
    }
    
    func layoutAmountSelectionView(amountSelectionView: AmountSelectionView) {
        
        
        
        
        
        //Main StackView
        //28% height
        //79% width
       /* let mainStackViewFrame = CGRect(x: 0.0, y: cancelButton.frame.maxY + 50.0, width: amountSelectionView.bounds.width * 0.79, height: amountSelectionView.bounds.height * 0.23)
        let mainStackView = UIStackView(frame: mainStackViewFrame)
        mainStackView.center.x = amountSelectionView.center.x
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.spacing = 5.0
 */
        
        
        //innerStackView
      /*  let innerStackViewFrame = CGRect(x: 0.0, y: 0.0, width: amountSelectionView.bounds.width * 0.79, height: 30.0)
        let innerStackView = UIStackView(frame: innerStackViewFrame)
        innerStackView.center.x = amountSelectionView.center.x
        innerStackView.axis = .horizontal
        innerStackView.distribution = .equalSpacing
        innerStackView.alignment = .center
        innerStackView.spacing = 5.0
 */
        
        //wetLabel
        
        //innerStackView.addArrangedSubview(wetLabel)
        
        
        //mainStackView.addArrangedSubview(catFoodImageView)
        //mainStackView.addArrangedSubview(catFoodLabel)
        //mainStackView.addArrangedSubview(innerStackView)
        //mainStackView.setNeedsLayout()
        
        //amountSelectionView.addSubview(mainStackView)
        
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
