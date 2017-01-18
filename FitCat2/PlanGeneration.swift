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
//    @IBOutlet weak var gotItBtn: UIButton!
    
    var newCat: CreateCatModel!
    var plan = PlanModel()
    var catFeedingModel = CatFeedingModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func generatePlan(_ sender: UIButton) {
        let initial_bcs = newCat.initial_bcs
        let initial_weight = newCat.initial_weight
        let weightNeedToLoss = Double(initial_bcs - 5) * 0.075 * Double(initial_weight)!
        let monthNeeded = Double(initial_bcs - 5) * 7.5
        let weightLossPerMonth = weightNeedToLoss / monthNeeded
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        print("weight need to lose:\(weightNeedToLoss)")
        print("month needed:\(monthNeeded)")
        let monthNeededInt = Int(monthNeeded)
        let monthRestDouble = monthNeeded - Double(Int(monthNeeded))

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        let result = formatter.string(from: date)

        plan.cat_id = newCat.cat_id
        plan.start_date = result

        
        var endDate = Calendar.current.date(byAdding: .month, value: monthNeededInt, to: Date())
        
        let enddateFM1 = formatter.string(from: endDate!)
        print("end:\(enddateFM1)");
        
        let interval = TimeInterval(60 * 60 * 24 * 30 * monthRestDouble)
        endDate = endDate?.addingTimeInterval(interval)
        let enddateFM = formatter.string(from: endDate!)
        print("end:\(enddateFM)");

        
        plan.end_date = enddateFM
        plan.weight_lose = weightNeedToLoss
        plan.weight_lose_per_month = weightLossPerMonth
        plan.calories_to_lose_per_day = 0.8 * (30 * Double(newCat.initial_weight)! + 70)
        
        catFeedingModel.cat_id = newCat.cat_id
        catFeedingModel.cat_name = newCat.name
        catFeedingModel.calories_total = plan.calories_to_lose_per_day
        catFeedingModel.current_bcs = newCat.initial_bcs
        catFeedingModel.calories_total = plan.food_volume_required
        
        catFeedingModel.weight_lose = plan.weight_lose
        catFeedingModel.initial_weight = Float(newCat.initial_weight)!
        catFeedingModel.current_weight = Float(newCat.initial_weight)!
        catFeedingModel.image_ID = newCat.image_id
        
        plan.save()
        catFeedingModel.save()
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/createPlan.php?a1=\(plan.cat_id)&a2=\(plan.start_date)&a3=\(plan.end_date)&a4=\(plan.weight_lose)&a5=\(plan.weight_lose_per_month)&a6=\(plan.calories_to_lose_per_day)&a7=\(plan.food_volume_required)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                self.plan.plan_id = Int(utf8Text)!
                print("PlanID:\(self.plan.plan_id)")
                
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "planView")
                self.present(dest!, animated: true, completion: nil)
                
            }
        }
        
        
        let parameters: Parameters = [
            "photoID": "\(newCat.image_id)",
            "catID": "\(newCat.cat_id)"
        ]
        
        // All three of these calls are equivalent
        Alamofire.request("http://mingplusyang.com/fitcatDB/catPhotoID.php", method: .post, parameters: parameters)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
