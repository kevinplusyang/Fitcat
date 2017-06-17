//
//  PlanModel.swift
//  FitCat2
//
//  Created by Austin Astorga on 1/6/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class PlanModel: NSObject {
    
     var planStartDate: Date?
     var planEndDate: Date?
     var catTotalWeightLoss: Double?
     var catWeightLossPerMonth: Double?
     var catCalories: Double?
    
     init(planStartDate: Date?, planEndDate: Date?, catTotalWeightLoss: Double?, catWeightLossPerMonth: Double?, catCalories: Double?) {
         self.planStartDate = planStartDate
         self.planEndDate = planEndDate
         self.catTotalWeightLoss = catTotalWeightLoss
         self.catWeightLossPerMonth = catWeightLossPerMonth
         self.catCalories = catCalories
     }
}
