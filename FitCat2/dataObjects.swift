//
//  dataObjects.swift
//  FitCat2
//
//  Created by Ming Yang on 11/21/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import Foundation


class currentCat {
    var cat_id : Int = 0
    var cat_name: String = "Ming"
    var weight_lose: Double = 5
    var calories_total: Double = 200
    var calories_today: Double = 50
    var food_total: Double = 400
    var food_today: Double = 100
    var initial_weight: Float = 0
    var current_weight: Float = 0
    var initial_bcs: Int = 7
    var goal_bcs: Int = 7
}

class CreateCat {
    var user_id : Int = 0
    var name: String = ""
    var birthday: String = ""
    var breed_id: String = ""
    var initial_weight: String = ""
    var neutered: Int = 0
    var gender: Int = 0
    var initial_bcs: Int = 7
    var image_id: String = ""
    var cat_id : Int = 0
}

class LoginClass {
    var f_id : Int = 0
    var f_name: String = ""
    
}

var floginobj = LoginClass()
var createCatObj = CreateCat()
var currentCatObj = currentCat()
