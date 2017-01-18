//
//  dataObjects.swift
//  FitCat2
//
//  Created by Ming Yang on 11/21/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import Foundation
import UIKit


class currentCat {
    var cat_id : Int = 0  //Useful index
    var cat_name: String = "Current Cat Name" //Display Useful
    var calories_total: Double = 200 //Display Useful
    var calories_today: Double = 50  //Display Useful
    var food_total: Double = 400  //Display Useful
    var food_today: Double = 100  //Display Useful
    var goal_weight: Float = 0 //Display Useful
    var current_weight: Float = 0  //Display Useful
    var current_bcs: Int = 7  //Display Useful
    var goal_bcs: Int = 5  //Goal BCS, typically is 5
    var weight_lose: Double = 5
    var initial_weight: Float = 0
    var image_ID: String = "Current Cat Name"
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
    var catImage : UIImage = #imageLiteral(resourceName: "catImagePlaceHolder")
}

class LoginClass {
    var f_id : Int = 0
    var f_name: String = ""
}

class PlanObj {
    var cat_id : Int = 0
    var start_date: String = ""
    var end_date: String = ""
    var weight_lose: Double = 5
    var weight_lose_per_month: Double = 0
    var calories_to_lose_per_day: Double = 0
    var food_volume_required: Double = 0
    var plan_id : Int = 0
    
}

class FoodSelection {
    var foodID : Int = 0
    var foodName : String = ""
    var ifWet: Int = 2;
    var cal: Float = 0
    var standardCan : Float = 0
}

var planObj = PlanObj()
var floginobj = LoginClass()
var createCatObj = CreateCat()
var currentCatObj = currentCat()
var foodSelection = FoodSelection()

class cleanData {
    func cleanCreateCat() {
        createCatObj.user_id = 0
        createCatObj.name = ""
        createCatObj.birthday = ""
        createCatObj.breed_id = ""
        createCatObj.initial_weight = ""
        createCatObj.neutered = 0
        createCatObj.gender = 0
        createCatObj.initial_bcs = 7
        createCatObj.image_id = ""
        createCatObj.cat_id = 0
    }
    
    func cleanPlan()  {
        planObj.cat_id = 0
        planObj.start_date = ""
        planObj.end_date = ""
        planObj.weight_lose = 5
        planObj.weight_lose_per_month = 0
        planObj.calories_to_lose_per_day = 0
        planObj.food_volume_required = 0
        planObj.plan_id = 0
    }
    
    func cleanCurrentCat() {
        currentCatObj.cat_id = 0  //Useful index
        currentCatObj.cat_name = "Current Cat Name" //Display Useful
        currentCatObj.calories_total = 200 //Display Useful
        currentCatObj.calories_today = 50  //Display Useful
        currentCatObj.food_total = 400  //Display Useful
        currentCatObj.food_today = 100  //Display Useful
        currentCatObj.goal_weight = 0 //Display Useful
        currentCatObj.current_weight = 0  //Display Useful
        currentCatObj.current_bcs = 7  //Display Useful
        currentCatObj.goal_bcs = 5  //Goal BCS, typically is 5
        currentCatObj.weight_lose = 5
        currentCatObj.initial_weight = 0
    }
}
