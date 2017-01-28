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
        //MARK: vvvvv target weight. final weight
        let weightNeedToLoss = Double(initial_bcs - 5) * 0.075 * initial_weight
        let monthNeeded = Double(initial_bcs - 5) * 7.5
        let weightLossPerMonth = weightNeedToLoss / monthNeeded
        let end_weight = initial_weight - weightNeedToLoss
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        
        print("weight need to lose:\(weightNeedToLoss)")
        print("month needed:\(monthNeeded)")
        let monthNeededInt = Int(monthNeeded)
        let monthRestDouble = monthNeeded - Double(Int(monthNeeded))

        let date = Date()

        let startDate = dateFormatter.string(from: date)
        let trimmedStartDate = dateFormatter.date(from: startDate)
        print("Start Date is : \(startDate)")
        plan.start_date = trimmedStartDate!
        var endDate = Calendar.current.date(byAdding: .month, value: monthNeededInt, to: trimmedStartDate!)
        
        let interval = TimeInterval(60 * 60 * 24 * 30 * monthRestDouble)
        endDate = endDate?.addingTimeInterval(interval)
        

        
        plan.end_date = endDate!
        plan.weight_lose = weightNeedToLoss
        plan.weight_lose_per_month = weightLossPerMonth
        plan.calories_to_lose_per_day = 0.8 * (30 * newCat.initial_weight + 70)
       
        catFeedingModel.calories_total = plan.calories_to_lose_per_day
        catFeedingModel.current_bcs = newCat.initial_bcs
        catFeedingModel.goal_weight = end_weight
        
        catFeedingModel.initial_weight = newCat.initial_weight
        catFeedingModel.current_weight = newCat.initial_weight
        newCat.cat_plan = plan
        newCat.cat_feeding = catFeedingModel
        newCat.save()
        
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "planView") as! planOverviewControllerViewController
        dest.cat = newCat
        self.present(dest, animated: true, completion: nil)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
