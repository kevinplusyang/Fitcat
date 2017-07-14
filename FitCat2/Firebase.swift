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
// swiftlint:disable force_cast
let appDelegate = UIApplication.shared.delegate as! AppDelegate
// swiftlint:enable force_cast
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
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width-30, height: 230)
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
            //print(foodObject)
            if let foodName = foodObject["name"] as? String, let style = foodObject["style"] as? String, let moisturePercent = foodObject["moisturePercent"] as? Double, let carbPercent = foodObject["carbPercent"] as? Int, let fatPercent = foodObject["fatPercent"] as? Double,
                let fiberPercent = foodObject["fiberPercent"] as? Double, let protienPercent = foodObject["proteinPercent"] as? Int, let kcalPerKg = foodObject["kcalPerKg"] as? Int {
                if style == "wet" {
                    var foodImage = #imageLiteral(resourceName: "catfood1")
                    if let imageBase64 = foodDictionary["image"] as? String {
                        let dataDecoded = Data(base64Encoded: imageBase64, options: .ignoreUnknownCharacters)!
                        let decodedImage = UIImage(data: dataDecoded)
                        foodImage = decodedImage!
                    }
                    var wetFoodArray: [[String: String]] = []
                    if let wetCalArray = foodObject["kcalPerCup"] as? NSArray {
                        for x in wetCalArray {
                            if
                                let  wetFoodDictionary = x as? NSDictionary,
                                let canSize = wetFoodDictionary["canSize"] as? String,
                                let kcalPerCup = wetFoodDictionary["kcalPerCup"] as? String  {
                                wetFoodArray.append(["canSize": canSize, "kcalPerCup": kcalPerCup])
                            }
                        }
                    }
                    let foodItem = FoodModel(foodName: foodName, style: style, moisturePercent: moisturePercent, carbPercent: carbPercent, fatPercent: fatPercent, fiberPercent: fiberPercent, proteinPercent: protienPercent, dryKCalPerCup: nil, wetKCalPerCup: wetFoodArray, kcalPerKg: kcalPerKg, image: foodImage)
                    finalFoodArray.append(foodItem)
                } else {
                    if let dryKCalPerCup = foodObject["kcalPerCup"] as? Int {
                        print("In DRY FOOD")
                        var dryFoodImage: UIImage = UIImage(named: "dryFoodTest")!
                            print("kcalPerCup")
                            if let imageBase64 = foodObject["image"] as? String {
                                let dataDecoded = Data(base64Encoded: imageBase64)!
                                let decodedImage = UIImage(data: dataDecoded)
                                print("found image")
                                dryFoodImage = decodedImage!
                            }
                            let foodItem = FoodModel(foodName: foodName, style: style, moisturePercent: moisturePercent, carbPercent: carbPercent, fatPercent: fatPercent, fiberPercent: fiberPercent, proteinPercent: protienPercent, dryKCalPerCup: dryKCalPerCup, wetKCalPerCup: nil, kcalPerKg: kcalPerKg, image: dryFoodImage)
                            finalFoodArray.append(foodItem)
                    }
                }
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
        if let catObject = catDictionary[catKey] as? NSDictionary,
            let currentKey = catKey as? String,
            let catPlanDictionary = catObject["catPlan"] as? [String: Any],
            let catFeedingDictionary = catObject["catFeeding"] as? [String: Any],
            let planStartDateString = catPlanDictionary["planStartDate"] as? String,
            let planEndDateString = catPlanDictionary["planEndDate"] as? String,
            let planStartDate =  dateFormatter.date(from: planStartDateString),
            let planEndDate = dateFormatter.date(from: planEndDateString),
            let catTotalWeightLoss = catPlanDictionary["catTotalWeightLoss"] as? Double,
            let catWeightLossPerMonth = catPlanDictionary["catWeightLossPerMonth"] as? Double,
            let catCalories = catPlanDictionary["catCalories"] as? Double,
            let caloriesTotal =  catFeedingDictionary["caloriesTotal"] as? Double,
            let caloriesToday = catFeedingDictionary["caloriesToday"] as? Double,
            let goalWeight = catFeedingDictionary["goalWeight"] as? Double,
            let currentWeight = catFeedingDictionary["currentWeight"] as? Double,
            let goalBcs = catFeedingDictionary["goalBcs"] as? Int,
            let weightLost = catFeedingDictionary["weightLost"] as? Double,
            let currentDateString = catFeedingDictionary["currentDate"] as? String,
            let currentDate = dateFormatter.date(from: currentDateString),
            let catName = catObject["catName"] as? String,
            let catBirthdayString = catObject["catBirthday"] as? String,
            let catBirthday = dateFormatter.date(from: catBirthdayString),
            let catBreed = catObject["catBreed"] as? String,
            let catInitialWeight = catObject["catInitialWeight"] as? Double,
            let catNeutered = catObject["catNeutered"] as? Int,
            let catGender = catObject["catGender"] as? Int,
            let catInitialBCS = catObject["catInitialBCS"] as? Int,
            let catPictureDataString = catObject["catPictureData"] as? String,
            let catPictureData = Data(base64Encoded: catPictureDataString) {
            let catPlan = PlanModel(planStartDate: planStartDate, planEndDate: planEndDate, catTotalWeightLoss: catTotalWeightLoss, catWeightLossPerMonth: catWeightLossPerMonth, catCalories: catCalories)
            var foodHistory: [String: Any]? = nil
            if let foodHistoryDictionary = catFeedingDictionary["foodHistory"] as? [String: Any] {
                foodHistory = foodHistoryDictionary
            }

            let catFeeding = CatFeedingModel(caloriesTotal: caloriesTotal, caloriesToday: caloriesToday, goalWeight: goalWeight, currentWeight: currentWeight, goalBcs: goalBcs, weightLost: weightLost, currentDate: currentDate, foodHistory: foodHistory)

            let cat = CreateCatModel(catName: catName, catBirthday: catBirthday, catBreed: catBreed, catInitialWeight: catInitialWeight, catNeutered: catNeutered, catGender: catGender, catInitialBCS: catInitialBCS, catPictureData: catPictureData, catPlan: catPlan, catFeeding: catFeeding, firebaseID: currentKey)
            finalCatArray.append(cat)
        }
    }
    return finalCatArray
}
