//
//  ViewController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/8/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos
import RealmSwift


class mainPageController: UIViewController,UITextFieldDelegate {
    
    
    var currentCount:Int = 0
    var maxCount: Int = 360
    var currentCat: CreateCatModel!
    
    var currentCatFeeding: CatFeedingModel!
    
    @IBOutlet var circularProgressView: KDCircularProgress!
    @IBOutlet var catImg: UIImageView!
    
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var weightsView: UIView!
    @IBOutlet weak var feedingView: UIView!
    
    @IBOutlet weak var feedingsBtn: UIButton!
    @IBOutlet weak var weightsBtn: UIButton!
    @IBOutlet weak var logBtn: UIButton!
    
    @IBOutlet weak var measureIconR: UIImageView!
    @IBOutlet weak var measureIconG: UIImageView!
    @IBOutlet weak var feedingIconR: UIImageView!
    @IBOutlet weak var feedingIconG: UIImageView!
    
    @IBOutlet weak var weigtBtnLabel: UILabel!
    @IBOutlet weak var feedingsBtnLabel: UILabel!
    
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var todayView: UIView!
    
    @IBOutlet weak var current_weight: UILabel!
    @IBOutlet weak var goal_weight: UILabel!
    @IBOutlet weak var current_BCS: UILabel!
    @IBOutlet weak var calories_remaining: UILabel!
    @IBOutlet weak var food_remaining: UILabel!
    
    @IBOutlet weak var caloriesProgress: UIProgressView!
    
    @IBOutlet weak var volumeProgress: UIProgressView!
    
    @IBOutlet weak var logWeightBtn: UIButton!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        currentCatFeeding = realm.objects(CatFeedingModel.self).filter({$0.cat_id == self.currentCat.cat_id}).first
        
//        Alamofire.request("http://mingplusyang.com/fitcatDB/getCurrentCat.php?catId=\(currentCat.cat_id)").responseJSON { response in
//            
//            if let jsonData = response.result.value {
//                let json = JSON(jsonData)
//                currentCatObj.cat_id = json["catId"].intValue  //Useful index
//                currentCatObj.cat_name = json["catName"].stringValue //Display Useful
//                currentCatObj.calories_total = json["calories_total"].doubleValue //Display Useful
//                currentCatObj.calories_today = json["calories_today"].doubleValue  //Display Useful
//                currentCatObj.food_total = json["food_total"].doubleValue //Display Useful
//                currentCatObj.food_today = json["food_today"].doubleValue  //Display Useful
//                currentCatObj.goal_weight = json["goal_weight"].floatValue //Display Useful
//                currentCatObj.current_weight = json["current_weight"].floatValue  //Display Useful
//                currentCatObj.current_bcs = json["current_bcs"].intValue //Display Useful
//                currentCatObj.goal_bcs = json["goal_bcs"].intValue  //Goal BCS, typically is 5
//                currentCatObj.weight_lose = json["weight_lose"].doubleValue
//                currentCatObj.initial_weight = json["initial_weight"].floatValue
//                currentCatObj.image_ID = json["img_ID"].stringValue
        
                self.current_weight.text = String(currentCatFeeding.current_weight) + " lb"
                self.current_BCS.text = String(currentCatFeeding.current_bcs) + " BCS"
                self.goal_weight.text = String(currentCatFeeding.goal_weight) + " lb"
                self.calories_remaining.text = String(Int(currentCatFeeding.calories_total - currentCatFeeding.calories_today))
                self.food_remaining.text = String(currentCatFeeding.food_total - currentCatFeeding.food_today)
                var temp1 = currentCatFeeding.calories_today / currentCatFeeding.calories_total
                var temp2 = currentCatFeeding.food_today / currentCatFeeding.food_total
                self.caloriesProgress.progress = 1 - Float(temp1)
                self.volumeProgress.progress = 1 - Float(temp2)
                self.catName.text = currentCatFeeding.cat_name
            //}
        //}

        //        print("asas")
        //        print(currentCatObj.cat_id)
        //         print(currentCatObj.cat_name)
        //         print(currentCatObj.calories_total)
        //         print(currentCatObj.calories_today)
        //         print(currentCatObj.food_total)
        //         print(currentCatObj.goal_weight)
        //         print(currentCatObj.current_weight)
        //         print(currentCatObj.current_bcs)
        //         print(currentCatObj.goal_bcs)
        //        print(currentCatObj.weight_lose)
        //         print(currentCatObj.initial_weight)
        
        current_weight.text = String(currentCatFeeding.current_weight)
        current_BCS.text = String(currentCatFeeding.current_bcs)
        goal_weight.text = String(currentCatFeeding.goal_weight) + " lb"
        calories_remaining.text = String(Int(currentCatFeeding.calories_total - currentCatFeeding.calories_today))
        food_remaining.text = String(currentCatFeeding.food_total - currentCatFeeding.food_today)
        caloriesProgress.progress = 1 - Float(temp1)
        volumeProgress.progress = 1 - Float(temp2)
        catName.text = currentCat.name

        // Do any additional setup after loading the view.
        //circularProgressView.angle = 0
        //round cat image
        
        catImg.layer.borderWidth = 1
        catImg.layer.masksToBounds = false
        catImg.layer.borderColor = UIColor.white.cgColor
        catImg.layer.cornerRadius = catImg.frame.height/2
        catImg.clipsToBounds = true
        
        //progress bar
        circularProgressView.startAngle = 90
        circularProgressView.progressThickness = 0.15
        circularProgressView.trackThickness = 0.3
        circularProgressView.clockwise = true
        circularProgressView.gradientRotateSpeed = 2
        circularProgressView.roundedCorners = false
        
        //hide weightsView
        weightsView.isHidden = true
        
        //change segments' UI style
        segments.layer.borderColor = UIColor.gray.cgColor
        
        //hide red measureIcon and grey feedingicon
        measureIconR.isHidden = true
        feedingIconG.isHidden = true
        
        //hide monthView yearView
        monthView.isHidden = true
        yearView.isHidden = true
        
        //log button rounded corner
        logBtn.layer.cornerRadius = 5
        current_weight.text = String(currentCatFeeding.current_weight) + " lb"
        current_BCS.text = String(currentCatFeeding.current_bcs) + " BCS"
        logWeightBtn.layer.cornerRadius = 5
        
        circularProgressView.animate(toAngle: Double(Float((currentCatFeeding.initial_weight - currentCatFeeding.current_weight))  / Float(currentCatFeeding.weight_lose) * 360), duration: 0.2, completion: nil)
        
        //        caloriesProgress.progress = 0.2
        //        volumeProgress.progress = 0.8
        
        self.weightTextField.delegate = self
        
        //        catImg.image = UIImage(named:"assets-library://asset/asset.JPG?id=87BC395F-5C08-4470-80BE-489575FF7DE7&ext=JPG")
        
        // declare your asset url
        let assetUrl = URL(string: currentCatFeeding.image_ID)!
        
        // retrieve the list of matching results for your asset url
        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assetUrl], options: nil)
        
        
        if let photo = fetchResult.firstObject {
            
            // retrieve the image for the first result
            PHImageManager.default().requestImage(for: photo, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: nil) {
                image, info in
                
                self.catImg.image = image //here is the image
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to calculate the new angle for the progress bar
    func newAngle() -> Int {
        return Int(360 * (currentCount / maxCount))
    }
    
    @IBAction func animateTapped(_ sender: UIButton) {
        if currentCount != maxCount {
            currentCount += 1
            print("currentCount \(currentCount)")
            let newAngleValue = newAngle()
            print("newAngleValue \(newAngleValue)")
            circularProgressView.animate(toAngle: Double(90), duration: 0.5, completion: nil)
        }
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        currentCount = 0
        circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
    }
    
    @IBAction func feedingsBtnTapped(_ sender: UIButton) {
        weightsView.isHidden = true
        feedingView.isHidden = false
        measureIconR.isHidden = true
        measureIconG.isHidden = false
        feedingIconG.isHidden = true
        feedingIconR.isHidden = false
        weigtBtnLabel.textColor = UIColor(red: 0.607843, green: 0.607843, blue: 0.607843, alpha: 1)
        feedingsBtnLabel.textColor = UIColor(red: 0.89411765, green: 0.34901961, blue: 0.25098039, alpha: 1)
    }
    
    @IBAction func weightsBtnTapped(_ sender: UIButton) {
        feedingView.isHidden = true
        weightsView.isHidden = false
        measureIconR.isHidden = false
        measureIconG.isHidden = true
        feedingsBtnLabel.textColor = UIColor(red: 0.607843, green: 0.607843, blue: 0.607843, alpha: 1)
        weigtBtnLabel.textColor = UIColor(red: 0.89411765, green: 0.34901961, blue: 0.25098039, alpha: 1)
        feedingIconG.isHidden = false
        feedingIconR.isHidden = true
        
    }
    
    @IBAction func segmentsChanged(_ sender: UISegmentedControl) {
        let index: Int = sender.selectedSegmentIndex
        let title: String = sender.titleForSegment(at: index)!
        print("segment clicked is \(title)")
        print("index clicked is \(index)")
        if (index == 0) {
            todayView.isHidden = false
            monthView.isHidden = true
            yearView.isHidden = true
        } else if (index == 1) {
            todayView.isHidden = true
            monthView.isHidden = false
            yearView.isHidden = true
        } else {
            todayView.isHidden = true
            monthView.isHidden = true
            yearView.isHidden = false
            
        }
    }
    
    @IBAction func logWeightBtnTapped(_ sender: UIButton) {
        var weight = Double(weightTextField.text!)!
        print("weight is \(weight)")
        Alamofire.request("http://mingplusyang.com/fitcatDB/addWeightRecord.php?a1=\(currentCatFeeding.cat_id)&a2=\(Double(weightTextField.text!)!)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                var result = 0
                print("Data: \(utf8Text)")
                self.current_weight.text = String(weight) + " lb"
                self.currentCatFeeding.current_weight = Float(weight)
                
                self.circularProgressView.animate(toAngle: Double(Float((self.currentCatFeeding.initial_weight - self.currentCatFeeding.current_weight))  / Float(self.currentCatFeeding.weight_lose) * 360), duration: 0.2, completion: nil)
                
            }
        }
    }
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        for textField in self.view.subviews where textField is UITextField {
    //            textField.resignFirstResponder()
    //        }
    //        return true
    //    }
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        weightTextField.resignFirstResponder()
    //        return true;
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.weightTextField.resignFirstResponder()
        
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        print("touchedBack")
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     segue.destinationViewController
     }
     */
    
}
