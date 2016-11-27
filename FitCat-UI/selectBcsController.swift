//
//  selectBcsController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/2/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit
import Alamofire


class selectBcsController: UIViewController {
    
    @IBOutlet weak var bcs7ol: UIButton!
    @IBOutlet weak var bcs8ol: UIButton!
    @IBOutlet weak var bcs9ol: UIButton!
   
    
    @IBOutlet weak var continueBtnOL: UIButton!
    
    override func viewDidLoad() {
        bcs7ol.backgroundColor = UIColor.clear
        bcs7ol.layer.borderWidth = 1
        bcs7ol.layer.borderColor = UIColor.white.cgColor
       
        
        continueBtnOL.backgroundColor = UIColor.clear
        continueBtnOL.layer.cornerRadius = 5
        continueBtnOL.layer.borderWidth = 1
        continueBtnOL.layer.borderColor = UIColor.white.cgColor
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        segue.destination
    }
    
    //BCS7 btn
    @IBAction func bcs7btn(_ sender: UIButton) {
        sender.backgroundColor = UIColor.clear
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
         bcs8ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
         bcs9ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
         createCatObj.initial_bcs = 7
    }
    
    //BCS8 btn
    @IBAction func bcs8btn(_ sender: UIButton) {
        sender.backgroundColor = UIColor.clear
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
        bcs7ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
         bcs9ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
         createCatObj.initial_bcs = 8
    }
    
    //BCS9 btn
    @IBAction func bcs9btn(_ sender: UIButton) {
        sender.backgroundColor = UIColor.clear
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
         bcs7ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
         bcs8ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
         createCatObj.initial_bcs = 9
        
    }
    
    
    //continue button
    @IBAction func continueBtnClicked(_ sender: UIButton) {
        print("What here is: \(createCatObj.name)")
       
        
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/createCat.php?a1=\(createCatObj.user_id)&a2=\(createCatObj.name)&a3=\(createCatObj.birthday)&a4=\(createCatObj.breed_id)&a5=\(createCatObj.initial_weight)&a6=\(createCatObj.neutered)&a7=\(createCatObj.gender)&a8=\(createCatObj.initial_bcs)&a9=\(createCatObj.image_id)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                createCatObj.cat_id = Int(utf8Text)!
                print("CatID:\(createCatObj.cat_id)")
            }
        }
        
        
        
        
    }
    

}
