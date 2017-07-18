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
    var style: String
    var moisturePercent: Double
    var carbPercent: Int
    var fatPercent: Double
    var fiberPercent: Double
    var protienPercent: Int
    var dryKCalPerCup: Int?
    var wetKCalPerCup: [[String:String]]?
    var kcalPerKg: Int
    var image: String
    
    
    init(foodName: String, style: String, moisturePercent: Double, carbPercent:Int, fatPercent: Double, fiberPercent: Double, proteinPercent: Int, dryKCalPerCup: Int?, wetKCalPerCup: [[String:String]]?, kcalPerKg: Int, image: String) {
        self.foodName = foodName
        self.style = style
        self.moisturePercent = moisturePercent
        self.carbPercent = carbPercent
        self.fatPercent = fatPercent
        self.fiberPercent = fiberPercent
        self.protienPercent = proteinPercent
        self.dryKCalPerCup = dryKCalPerCup
        self.wetKCalPerCup = wetKCalPerCup
        self.kcalPerKg = kcalPerKg
        self.image = image
        }
    
}
