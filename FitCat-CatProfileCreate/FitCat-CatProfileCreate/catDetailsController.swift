//
//  ViewController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 10/20/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit

class catDetailsController: UIViewController,UITextFieldDelegate {
    
    //cat profile img
    @IBOutlet weak var catProfileImg: UIImageView!
    
    //yes no label for Neutered
    @IBOutlet weak var yesNoLabel: UILabel!
    
    
    
    
    //UI TextFields
    @IBOutlet weak var catNameField: UITextField!
    @IBOutlet weak var catDobField: UITextField!
    @IBOutlet weak var catBreedField: UITextField!
    @IBOutlet weak var catWeightField: UITextField!
    
    //female btn outlet
    @IBOutlet weak var btn1ol: UIButton!
    
    //male btn outlet
    @IBOutlet weak var btn2ol: UIButton!
    
    //continue btn outlet
    @IBOutlet weak var btn3ol: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard when user done inputing
        self.catNameField.delegate = self
        self.catDobField.delegate = self
        self.catBreedField.delegate = self
        self.catWeightField.delegate = self
        
        //cat profile image UI: round images
        catProfileImg.layer.borderWidth = 1
        catProfileImg.layer.masksToBounds = false
        catProfileImg.layer.borderColor = UIColor.white.cgColor
        catProfileImg.layer.cornerRadius = catProfileImg.frame.height/2
        catProfileImg.clipsToBounds = true
        
        
        //text fields UIs
        btn1ol.backgroundColor = UIColor.clear
        btn1ol.layer.cornerRadius = 10
        btn1ol.layer.borderWidth = 1
        btn1ol.layer.borderColor = UIColor.white.cgColor
        
        btn3ol.backgroundColor = UIColor.clear
        btn3ol.layer.cornerRadius = 5
        btn3ol.layer.borderWidth = 1
        btn3ol.layer.borderColor = UIColor.white.cgColor

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "selectingBreed"){
            print("breedDetailTabed")
        }
    }
    
    
    //if textfield "catBreedField" is tapped, "selectingBreed" is triggered, and table view is shown
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == catBreedField){
            self.performSegue(withIdentifier: "selectingBreed", sender: self)
        }
    }
    
    
    //upload image btn
    @IBAction func uploadProfileImg(_ sender: UIButton) {
        
        
    }
    
    //continue btn
    @IBAction func btn3(_ sender: UIButton) {
        
        sender.layer.backgroundColor = UIColor(white: 1.0, alpha:0.1).cgColor
        
    }
    
    @IBAction func touchCancel(_ sender: UIButton){
        sender.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
    }
    
    //female btn
    @IBAction func btn1(_ sender: UIButton) {
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
        btn2ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
    }
    
    //male btn
    @IBAction func btn2(_ sender: UIButton) {
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
        btn1ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        
    }
    
    @IBAction func neuteredSwitch(_ sender: UISwitch){
        if sender.isOn {
            yesNoLabel.text = "Yes"
        }else{
            yesNoLabel.text = "No"
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    
    }
    
    


}

