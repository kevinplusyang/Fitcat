//
//  FoodSelectionModel.swift
//  FitCat2
//
//  Created by Austin Astorga on 1/6/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class FoodSelectionModel: NSObject {
    
     var foodID : Int = 0
     var foodName : String = ""
     var ifWet: Int = 2;
     var cal: Float = 0
     var standardCan : Float = 0
    
     init(foodID: Int, foodName: String, ifWet: Int, cal: Float, standardCan: Float) {
         self.foodID = foodID
         self.foodName = foodName
         self.ifWet = ifWet
         self.cal = cal
         self.standardCan = standardCan
     }
    
    
}
