//
//  CurrentCatModel.swift
//  FitCat2
//
//  Created by Austin Astorga on 1/12/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class CatFeedingModel: NSObject {

     var caloriesTotal: Double
     var caloriesToday: Double
     var goalWeight: Double
     var currentWeight: Double
     var goalBcs: Int
     var weightLost: Double
     var currentDate: Date
    var foodHistory: [String: Any]?
    
    init(caloriesTotal: Double, caloriesToday: Double, goalWeight: Double, currentWeight: Double, goalBcs: Int, weightLost: Double, currentDate: Date, foodHistory: [String:Any]?) {
         self.caloriesTotal = caloriesTotal
         self.caloriesToday = caloriesToday
         self.goalWeight = goalWeight
         self.currentWeight = currentWeight
         self.goalBcs = goalBcs
         self.weightLost = weightLost
         self.currentDate = currentDate
        self.foodHistory = foodHistory
     }
    
    
    
    
}
