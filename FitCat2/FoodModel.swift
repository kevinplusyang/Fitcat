//
//  FoodModel.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/25/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class FoodModel: NSObject {
    var foodName: String
    var caloriesPerCup: Double
    
    init(foodName: String, caloriesPerCup: Double) {
        self.foodName = foodName
        self.caloriesPerCup = caloriesPerCup
    }
    
}
