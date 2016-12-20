//
//  planOverviewControllerViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos

class planOverviewControllerViewController: UIViewController {
    
    //cat profile image
    
    @IBOutlet weak var catImg: UIImageView!
    
    //button outlet
//    @IBOutlet weak var gotItBtn: UIButton!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var weightLoss: UILabel!
    @IBOutlet weak var weightToLoss: UILabel!
    @IBOutlet weak var weightToLossPerMonth: UILabel!
    @IBOutlet weak var caloriesPerDay: UILabel!
    @IBOutlet weak var volumePerDay: UILabel!
    @IBOutlet weak var endDateBig: UILabel!
    
    @IBAction func gotItButton(_ sender: UIButton) {
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getCurrentCat.php?catId=\(planObj.cat_id)").responseJSON { response in

            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                currentCatObj.cat_id = json["catId"].intValue  //Useful index
                currentCatObj.cat_name = json["catName"].stringValue //Display Useful
                currentCatObj.calories_total = json["calories_total"].doubleValue //Display Useful
                currentCatObj.calories_today = json["calories_today"].doubleValue  //Display Useful
                currentCatObj.food_total = json["food_total"].doubleValue //Display Useful
                currentCatObj.food_today = json["food_today"].doubleValue  //Display Useful
                currentCatObj.goal_weight = json["goal_weight"].floatValue //Display Useful
                currentCatObj.current_weight = json["current_weight"].floatValue  //Display Useful
                currentCatObj.current_bcs = json["current_bcs"].intValue //Display Useful
                currentCatObj.goal_bcs = json["goal_bcs"].intValue  //Goal BCS, typically is 5
                currentCatObj.weight_lose = json["weight_lose"].doubleValue
                currentCatObj.initial_weight = json["initial_weight"].floatValue
                currentCatObj.image_ID = json["img_ID"].stringValue
                
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "mainPage")
                self.present(dest!, animated: true, completion: nil)
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //cat image
        catImg.layer.borderWidth = 1
        catImg.layer.masksToBounds = false
        catImg.layer.borderColor = UIColor.white.cgColor
        catImg.layer.cornerRadius = catImg.frame.height/2
        catImg.clipsToBounds = true
        
        let assetUrl = URL(string: createCatObj.image_id)!
        
        // retrieve the list of matching results for your asset url
        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assetUrl], options: nil)
        
        
        if let photo = fetchResult.firstObject {
            
            // retrieve the image for the first result
            PHImageManager.default().requestImage(for: photo, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: nil) {
                image, info in
                
                self.catImg.image = image //here is the image
            }
        }
        
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getCatIdByPlan.php?a1=\(planObj.plan_id)").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                planObj.cat_id = Int(utf8Text)!
            }
        }
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getEndDateByPlan.php?a1=\(planObj.plan_id)").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //                self.endDate.text = "\(utf8Text)"
                planObj.end_date = utf8Text
            }
        }
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getStartDateByPlan.php?a1=\(planObj.plan_id)").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                planObj.start_date = utf8Text
            }
        }
        
        
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getWeightLosePerMonthByPlan.php?a1=\(planObj.plan_id)").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                planObj.weight_lose_per_month = Double(utf8Text)!
                
            }
        }
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getWeightLossByPlan.php?a1=\(planObj.plan_id)").response { response in
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

