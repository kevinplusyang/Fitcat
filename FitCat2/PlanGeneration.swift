//
//  planGeneration.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Foundation
import Alamofire







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
        
        
        planObj.cat_id = createCatObj.cat_id
        planObj.start_date = result
        
        result = formatter.string(from: date.addingTimeInterval(monthNeeded*30*24*60*60))
        planObj.end_date = result
        planObj.weight_lose = weightNeedToLoss
        planObj.weight_lose_per_month = weightLossPerMonth
        planObj.calories_to_lose_per_day = 0.8 * (30 * Double(createCatObj.initial_weight)! + 70)
        
        
        
        
        
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/createPlan.php?a1=\(planObj.cat_id)&a2=\(planObj.start_date)&a3=\(planObj.end_date)&a4=\(planObj.weight_lose)&a5=\(planObj.weight_lose_per_month)&a6=\(planObj.calories_to_lose_per_day)&a7=\(planObj.food_volume_required)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                planObj.plan_id = Int(utf8Text)!
                print("PlanID:\(planObj.plan_id)")
                
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "planView")
                self.present(dest!, animated: true, completion: nil)
                
            }
        }
        
        
        let parameters: Parameters = [
            "photoID": "\(createCatObj.image_id)",
            "catID": "\(createCatObj.cat_id)"
        ]
        
        // All three of these calls are equivalent
        Alamofire.request("http://mingplusyang.com/fitcatDB/catPhotoID.php", method: .post, parameters: parameters)
        
        

        
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
