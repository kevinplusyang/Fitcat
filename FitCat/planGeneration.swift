//
//  planGeneration.swift
//  FitCat
//
//  Created by Kevin Yang on 11/8/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import UIKit
import Foundation
import Alamofire


class PlanObj {
    var cat_id : Int = 0
    var start_date: String = ""
    var end_date: String = ""
    var weight_lose: Double = 0
    var weight_lose_per_month: Double = 0
    var calories_to_lose_per_day: Double = 0
    var food_volume_required: Double = 0
    var plan_id : Int = 0
    
}

var planObj = PlanObj()




class planGeneration: UIViewController, UITextFieldDelegate {
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    @IBAction func generatePlan(_ sender: UIButton) {
        let initial_bcs = createCatObj.initial_bcs
        let initial_weight = createCatObj.initial_weight
        var weightNeedToLoss = Double(initial_bcs - 5) * 0.075 * Double(initial_weight)!
        var monthNeeded = Double(initial_bcs - 5) * 7.5
        var weightLossPerMonth = weightNeedToLoss / monthNeeded
        
        let currentDate = NSData()
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
//        var newDateFormat = dateFormatter.date(from: currentDate)
        
        var date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        var result = formatter.string(from: date)
        
        
//        print("initial_bcs\(initial_bcs)")
//        print("initial_weight\(initial_weight)")
//        print("weightNeedToLoss\(weightNeedToLoss)")
//        print("monthNeeded\(monthNeeded)")
//        print("weightLossPerMonth\(weightLossPerMonth)")
        
       
        planObj.cat_id = createCatObj.cat_id
        planObj.start_date = result
        
        result = formatter.string(from: date.addingTimeInterval(monthNeeded*30*24*60*60))
        planObj.end_date = result
        planObj.weight_lose = weightNeedToLoss
        planObj.weight_lose_per_month = weightLossPerMonth
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/createPlan.php?a1=\(planObj.cat_id)&a2=\(planObj.start_date)&a3=\(planObj.end_date)&a4=\(planObj.weight_lose)&a5=\(planObj.weight_lose_per_month)&a6=\(planObj.calories_to_lose_per_day)&a7=\(planObj.food_volume_required)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                planObj.plan_id = Int(utf8Text)!
                print("PlanID:\(planObj.plan_id)")
                
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "mainView")
                self.present(dest!, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
