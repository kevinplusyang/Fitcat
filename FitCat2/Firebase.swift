//
//  Firebase.swift
//  FitCat
//
//  Created by Austin Astorga on 4/21/17.
//  Copyright © 2017 Austin Astorga. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

private var authHandle: NSObjectProtocol?
let firebaseRef = FIRDatabase.database().reference()
let userDefaults = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate as! AppDelegate
var activeUser: FIRUser!

func startSignIn() {
    authHandle = FIRAuth.auth()?.addStateDidChangeListener(authStateDidChange)
}

private func authStateDidChange(_ auth: FIRAuth, _ user: FIRUser?) {
    if let authHandle = authHandle {
        // This is important, because otherwise the listener will stay alive
        // and send events at least every hour
        FIRAuth.auth()?.removeStateDidChangeListener(authHandle)
    }
    
    if let user = user {
        //FIREBASE: We have a user, so we can present main collection view
        if(activeUser != user) {
            activeUser = user
            userDidSignIn(activeUser)
        }
    } else {
        signIn()
    }
}

private func signIn() {
    //Present sign in page
    let signInVC = InitialViewController()
    appDelegate.navigationController.pushViewController(signInVC, animated: true)
}

func userDidSignIn(_ user: FIRUser) {
    //Signed in
    //If user isn't in DB, then set it up

    if !userDefaults.bool(forKey: "tos") {
        let tosVC = TermsOfServiceViewController()
        userDefaults.set(true, forKey: "tos")
        appDelegate.navigationController.pushViewController(tosVC, animated: true)
    } else {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        flowLayout.minimumLineSpacing = 25.0
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width-30 ,height: 230)
        let catCardVC = CatCardCollectionViewController(collectionViewLayout: flowLayout)
        appDelegate.navigationController.pushViewController(catCardVC, animated: true)
    }
}

func initializeNewUser(parameters: [String: Any], uid: String) {
    firebaseRef.child("users").child(uid).setValue(parameters)
}

func updateUser(parameters: [String: Any]) {
    if let user = FIRAuth.auth()?.currentUser {
        let newCatRef = firebaseRef.child("users").child(user.uid).child("catCollection").childByAutoId()
        newCatRef.setValue(parameters)
    } else {
        print("Couldnt update user")
    }
}

func prepareNewCatParameters(cat: CreateCatModel) -> [String: Any] {
    
    var catDictionary: [String: Any] = [:]
    catDictionary["catName"] = cat.catName
    catDictionary["catBirthday"] = String(describing: cat.catBirthday)
    catDictionary["catBreed"] = cat.catBreed
    catDictionary["catInitialWeight"] = cat.catInitialWeight
    catDictionary["catNeutered"] = cat.catNeutered
    catDictionary["catGender"] = cat.catGender
    catDictionary["catInitialBCS"] = cat.catInitialBCS
    catDictionary["catPictureData"] = cat.catPictureData.base64EncodedString()
    
    var catPlanDictionary: [String: Any] = [:]
    catPlanDictionary["planStartDate"] = String(describing: cat.catPlan.planStartDate!)
    catPlanDictionary["planEndDate"] = String(describing: cat.catPlan.planEndDate!)
    catPlanDictionary["catTotalWeightLoss"] = cat.catPlan.catTotalWeightLoss
    catPlanDictionary["catWeightLossPerMonth"] = cat.catPlan.catWeightLossPerMonth
    catPlanDictionary["catCalories"] = cat.catPlan.catCalories
    
    var catFeedingDictionary: [String: Any] = [:]
    catFeedingDictionary["caloriesTotal"] = cat.catFeeding.caloriesTotal
    catFeedingDictionary["caloriesToday"] = cat.catFeeding.caloriesToday
    catFeedingDictionary["goalWeight"] = cat.catFeeding.goalWeight
    catFeedingDictionary["currentWeight"] = cat.catFeeding.currentWeight
    catFeedingDictionary["goalBcs"] = cat.catFeeding.goalBcs
    catFeedingDictionary["weightLost"] = cat.catFeeding.weightLost
    catFeedingDictionary["currentDate"] = String(describing: cat.catFeeding.currentDate)
    
    catDictionary["catPlan"] = catPlanDictionary
    catDictionary["catFeeding"] = catFeedingDictionary
    
    return catDictionary
}

func createFoodArray(foodDictionary: NSDictionary) -> [FoodModel] {
    let foodKeys = foodDictionary.allKeys
    var finalFoodArray: [FoodModel] = []
    for foodKey in foodKeys {
        if let foodObject = foodDictionary[foodKey] as? NSDictionary {
            if let caloriesPerCup = foodObject["caloriesPerCup"] as? Int, let foodName = foodObject["foodName"] as? String {
                let caloriesPerCupDouble = Double(caloriesPerCup)
                let foodItem = FoodModel(foodName: foodName, caloriesPerCup: caloriesPerCupDouble)
                finalFoodArray.append(foodItem)
            }
        }
    }
    return finalFoodArray
}

func createCatArray(catDictionary: NSDictionary) -> [CreateCatModel] {
    let catKeys = catDictionary.allKeys
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    var finalCatArray: [CreateCatModel] = []
    for catKey in catKeys {
        if let catObject = catDictionary[catKey] as? NSDictionary {
            let catPlanDictionary = catObject["catPlan"] as! [String: Any]
            let catFeedingDictionary = catObject["catFeeding"] as! [String: Any]
            let catPlan = PlanModel(planStartDate: dateFormatter.date(from: catPlanDictionary["planStartDate"] as! String), planEndDate: dateFormatter.date(from: catPlanDictionary["planEndDate"] as! String), catTotalWeightLoss: (catPlanDictionary["catTotalWeightLoss"] as! Double), catWeightLossPerMonth: (catPlanDictionary["catWeightLossPerMonth"] as! Double), catCalories: (catPlanDictionary["catCalories"] as! Double))
            let catFeeding = CatFeedingModel(caloriesTotal: catFeedingDictionary["caloriesTotal"] as! Double, caloriesToday: catFeedingDictionary["caloriesToday"] as! Double, goalWeight: catFeedingDictionary["goalWeight"] as! Double, currentWeight: catFeedingDictionary["currentWeight"] as! Double, goalBcs: catFeedingDictionary["goalBcs"] as! Int, weightLost: catFeedingDictionary["weightLost"] as! Double, currentDate: dateFormatter.date(from: catFeedingDictionary["currentDate"] as! String)!)
            
            //let catName = catObject["catName"] as! String
            //let catBirthday = dateFormatter.date(from: catObject["catBirthday"] as! String)!
            //let catBreed = catObject["catBreed"] as! String
            //let catInitialWeight = catObject["catInitialWeight"] as! Double
            //let catNeutered = catObject["catNeutered"] as! Int
           // let catGender =
            let cat = CreateCatModel(catName: catObject["catName"] as! String, catBirthday: dateFormatter.date(from: catObject["catBirthday"] as! String)!, catBreed: catObject["catBreed"] as! String, catInitialWeight: catObject["catInitialWeight"] as! Double, catNeutered: catObject["catNeutered"] as! Int, catGender: catObject["catGender"] as! Int, catInitialBCS: catObject["catInitialBCS"] as! Int, catPictureData: Data(base64Encoded: (catObject["catPictureData"] as! String))! , catPlan: catPlan, catFeeding: catFeeding)
            finalCatArray.append(cat)
            
        }
    }
    return finalCatArray
}




