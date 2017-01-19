//
//  amountSelectionViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/28/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire

class amountSelectionViewController: UIViewController {
    
    let foodSelection = FoodSelectionModel()
    
    //@IBOutlet weak var addToBowlBtn: UIButton!
    @IBOutlet weak var FeedBtn: UIButton!
    @IBOutlet weak var wetDrylabel: UILabel!
    @IBOutlet weak var cupLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var calDataLabel: UILabel!
    @IBOutlet weak var cupOrCanLabel: UILabel!
    @IBOutlet weak var unitDataLabel: UILabel!
    @IBOutlet weak var cupOrCanLabel2: UILabel!
    @IBOutlet weak var calProgressBar: UIProgressView!
    @IBOutlet weak var foodProgressBar: UIProgressView!
    @IBAction func feedAction(_ sender: UIButton) {
        print("clicked")
        print("OO:\(caloriesLabel.text)")
        var calTemp = caloriesLabel.text
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        
        var volumeTemp = volumeLabel.text
        volumeTemp = volumeTemp?.substring(to: (volumeTemp?.index(before:(volumeTemp?.endIndex)!))!)
        volumeTemp = volumeTemp?.substring(to: (volumeTemp?.index(before:(volumeTemp?.endIndex)!))!)
        volumeTemp = volumeTemp?.substring(to: (volumeTemp?.index(before:(volumeTemp?.endIndex)!))!)
        
        
    
        print("OO:\(Float(calTemp!))")
        print("OO:\(Float(volumeTemp!))")

        
        Alamofire.request("http://mingplusyang.com/fitcatDB/addFeedingRecord.php?a1=\(33)&a2=\(foodSelection.foodID)&a3=\(calTemp!)&a4=\(volumeTemp!)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        amountView.layer.cornerRadius = 8
        wetDrylabel.layer.cornerRadius = 10
        //addToBowlBtn.layer.cornerRadius = 5
        FeedBtn.layer.cornerRadius = 5
    
        print("vv:\(foodSelection.foodID)")
        print("vv:\(foodSelection.foodName)")
        print("vv:\(foodSelection.ifWet)")
        print("vv:\(foodSelection.cal)")
        print("vv:\(foodSelection.standardCan)")
        
        foodNameLabel.text = foodSelection.foodName
        calDataLabel.text = String(foodSelection.cal)
        unitDataLabel.text = String(foodSelection.standardCan)
        caloriesLabel.text = "\(foodSelection.cal * 0.25) Cal"
        calProgressBar.progress = 0.25 / 2
        volumeLabel.text = "\(8 * 0.25 ) oz"
        foodProgressBar.progress = 0.25 / 2
        
        if(foodSelection.ifWet == 0){
            wetDrylabel.text! = "Dry"
            wetDrylabel.backgroundColor = UIColor.black
            cupOrCanLabel.text = "Cal/Cup"
            unitDataLabel.text = "8"
            cupOrCanLabel2.text = "oz. Cup"
            cupLabel.text = "1/4 Cup"
            caloriesLabel.text = "\(foodSelection.cal * 0.25) Cal"
            calProgressBar.progress = 0.25 / 2
            volumeLabel.text = "\(8 * 0.25 ) oz"
            foodProgressBar.progress = 0.25 / 2
        }
        
        foodImg.image = UIImage(named:"\(foodSelection.foodName)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        // Make slider stop every round number size.
        sender.setValue(Float(roundf(sender.value)), animated: true)
        // Define the current value as float.
        let currentValue = Float(sender.value/4)
        // Format slider value with two decimal points.
       
        if(foodSelection.ifWet == 0){
            let decimalValue = NSString(format: "%.2f", currentValue)
            // Output slider value in our label. for wet food
            if (decimalValue == "0.00"){
                cupLabel.text! = "0 Cup"
                calProgressBar.progress = 0.00 / 2
                foodProgressBar.progress = 0.00 / 2
                caloriesLabel.text = "\(foodSelection.cal * 0) Cal"
                volumeLabel.text = "\(8 * 0 ) oz"
            }else if(decimalValue == "0.25"){
                cupLabel.text! = "1/4 Cup"
                calProgressBar.progress = 0.25 / 2
                foodProgressBar.progress = 0.25 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 0.25) Cal"
                 volumeLabel.text = "\(8 * 0.25 ) oz"
            }else if(decimalValue == "0.50"){
                cupLabel.text! = "1/2 Cup"
                calProgressBar.progress = 0.50 / 2
                 foodProgressBar.progress = 0.50 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 0.50) Cal"
                 volumeLabel.text = "\(8 * 0.50 ) oz"
            }else if(decimalValue == "0.75"){
                cupLabel.text! = "3/4 Cup"
                calProgressBar.progress = 0.75 / 2
                foodProgressBar.progress = 0.75 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 0.75) Cal"
                 volumeLabel.text = "\(8 * 0.75 ) oz"
            }else if(decimalValue == "1.00"){
                cupLabel.text! = "1 Cup"
                calProgressBar.progress = 1.00 / 2
                foodProgressBar.progress = 1.00 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1) Cal"
                 volumeLabel.text = "\(8 * 1.00 ) oz"
            }else if(decimalValue == "1.25"){
                cupLabel.text! = "1 and 1/4 Cup"
                calProgressBar.progress = 1.25 / 2
                foodProgressBar.progress = 1.25 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1.25) Cal"
                 volumeLabel.text = "\(8 * 1.25 ) oz"
            }else if(decimalValue == "1.50"){
                cupLabel.text! = "1 and 1/2 Cup"
                calProgressBar.progress = 1.50 / 2
                 foodProgressBar.progress = 1.50 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1.50) Cal"
                 volumeLabel.text = "\(8 * 1.50 ) oz"
            }else if(decimalValue == "1.75"){
                cupLabel.text! = "1 and 3/4 Cup"
                calProgressBar.progress = 1.75 / 2
                foodProgressBar.progress = 1.75 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1.75) Cal"
                 volumeLabel.text = "\(8 * 1.75 ) oz"
            }else if(decimalValue == "2.00"){
                cupLabel.text! = "2 Cup"
                calProgressBar.progress = 2.00 / 2
                foodProgressBar.progress = 2.00 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 2.00) Cal"
                 volumeLabel.text = "\(8 * 2.00 ) oz"
            }

        } else {
            let decimalValue = NSString(format: "%.2f", currentValue)
            
            // Output slider value in our label. for wet food
            if (decimalValue == "0.00") {
                cupLabel.text! = "0 Can"
                 calProgressBar.progress = 0.00 / 2
                 foodProgressBar.progress = 0.00 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 0) Cal"
                 volumeLabel.text = "\(8 * 0.00 ) oz"
            } else if(decimalValue == "0.25") {
                cupLabel.text! = "1/4 Can"
                 calProgressBar.progress = 0.25 / 2
                 foodProgressBar.progress = 0.25 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 0.25) Cal"
                 volumeLabel.text = "\(8 * 0.25 ) oz"
            } else if(decimalValue == "0.50") {
                cupLabel.text! = "1/2 Can"
                 calProgressBar.progress = 0.50 / 2
                 foodProgressBar.progress = 0.50 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 0.50) Cal"
                 volumeLabel.text = "\(8 * 0.50 ) oz"
            } else if(decimalValue == "0.75") {
                cupLabel.text! = "3/4 Can"
                 calProgressBar.progress = 0.75 / 2
                 foodProgressBar.progress = 0.75 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 0.75) Cal"
                volumeLabel.text = "\(8 * 0.75 ) oz"
            } else if(decimalValue == "1.00") {
                cupLabel.text! = "1 Can"
                 calProgressBar.progress = 1.00 / 2
                 foodProgressBar.progress = 1.00 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1.00) Cal"
                 volumeLabel.text = "\(8 * 1.00 ) oz"
            } else if(decimalValue == "1.25"){
                cupLabel.text! = "1 and 1/4 Can"
                 calProgressBar.progress = 1.25 / 2
                 foodProgressBar.progress = 1.25 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1.25) Cal"
                 volumeLabel.text = "\(8 * 1.25 ) oz"
            } else if(decimalValue == "1.50") {
                cupLabel.text! = "1 and 1/2 Can"
                 calProgressBar.progress = 1.50 / 2
                 foodProgressBar.progress = 1.50 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1.50) Cal"
                 volumeLabel.text = "\(8 * 1.50 ) oz"
            } else if(decimalValue == "1.75") {
                cupLabel.text! = "1 and 3/4 Can"
                 calProgressBar.progress = 1.75 / 2
                 foodProgressBar.progress = 1.75 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 1.75) Cal"
                 volumeLabel.text = "\(8 * 1.75 ) oz"
            } else if(decimalValue == "2.00") {
                cupLabel.text! = "2 Cans"
                 calProgressBar.progress = 2.00 / 2
                 foodProgressBar.progress = 2.00 / 2
                 caloriesLabel.text = "\(foodSelection.cal * 2.00) Cal"
                 volumeLabel.text = "\(8 * 2.00 ) oz"
            }
        }
        //cupLabel.text! = "\(decimalValue)"
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

