//
//  selectBcsController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/2/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit


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
    }
    
    //BCS8 btn
    @IBAction func bcs8btn(_ sender: UIButton) {
        sender.backgroundColor = UIColor.clear
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
        bcs7ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
         bcs9ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
    }
    
    //BCS9 btn
    @IBAction func bcs9btn(_ sender: UIButton) {
        sender.backgroundColor = UIColor.clear
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
         bcs7ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
         bcs8ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
    }
    
    
    //continue button
    @IBAction func continueBtnClicked(_ sender: UIButton) {
        
    }
    

}
