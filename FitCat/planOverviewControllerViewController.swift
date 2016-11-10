//
//  planOverviewControllerViewController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/6/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit
import Alamofire

class planOverviewControllerViewController: UIViewController {
    
    //cat profile image
    
    @IBOutlet weak var catImg: UIImageView!
    
    //button outlet
    @IBOutlet weak var gotItBtn: UIButton!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var weightLoss: UILabel!
    @IBOutlet weak var weightToLoss: UILabel!
    @IBOutlet weak var weightToLossPerMonth: UILabel!
    @IBOutlet weak var caloriesPerDay: UILabel!
    @IBOutlet weak var volumePerDay: UILabel!
    @IBOutlet weak var endDateBig: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //cat image
        catImg.layer.borderWidth = 1
        catImg.layer.masksToBounds = false
        catImg.layer.borderColor = UIColor.white.cgColor
        catImg.layer.cornerRadius = catImg.frame.height/2
        catImg.clipsToBounds = true
        
        //button UI editing
        gotItBtn.backgroundColor = UIColor.clear
        gotItBtn.layer.cornerRadius = 5
        gotItBtn.layer.borderWidth = 1
        gotItBtn.layer.borderColor = UIColor.white.cgColor
        
        
        
    
        Alamofire.request("http://mingplusyang.com/fitcatDB/getCatIdByPlan.php?a1=1").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
               planObj.cat_id = Int(utf8Text)!
            }
        }
    
        Alamofire.request("http://mingplusyang.com/fitcatDB/getEndDateByPlan.php?a1=1").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                self.endDate.text = "\(utf8Text)"
                planObj.end_date = utf8Text
            }
        }
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getStartDateByPlan.php?a1=1").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                planObj.start_date = utf8Text
            }
        }
       
       
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getWeightLosePerMonthByPlan.php?a1=1").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                planObj.weight_lose_per_month = Double(utf8Text)!
                
            }
        }
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getWeightLossByPlan.php?a1=1").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                planObj.weight_lose = Double(utf8Text)!
            
            }
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.startDate.text = planObj.start_date
            self.endDate.text = planObj.end_date
            self.weightLoss.text = "\(planObj.weight_lose)lb 5BCS"
            self.weightToLoss.text = "\(planObj.weight_lose) lbs"
            self.weightToLossPerMonth.text = "\(planObj.weight_lose_per_month) lbs"
            self.caloriesPerDay.text = "\(planObj.calories_to_lose_per_day) Cal"
            self.volumePerDay.text = "\(planObj.food_volume_required) OZ"
            self.endDateBig.text = planObj.end_date
        })
    
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
