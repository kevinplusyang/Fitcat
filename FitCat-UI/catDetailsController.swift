//
//  catDetailsController.swift
//  FitCat
//
//  Created by Kevin Yang on 11/3/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class CreateCat {
    var user_id : Int = 0
    var name: String = ""
    var birthday: String = ""
    var breed_id: Int = 0
    var initial_weight: String = ""
    var neutered: Int = 0
    var gender: Int = 0
    var initial_bcs: Int = 7
    var image_id: String = ""
    var cat_id : Int = 0
}

var createCatObj = CreateCat()

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

    var datePicker = UIDatePicker()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //cat profile image UI: round images
        catProfileImg.layer.borderWidth = 1
        catProfileImg.layer.masksToBounds = false
        catProfileImg.layer.borderColor = UIColor.white.cgColor
        catProfileImg.layer.cornerRadius = catProfileImg.frame.height/2
        catProfileImg.clipsToBounds = true
        
        btn1ol.backgroundColor = UIColor.clear
        btn1ol.layer.cornerRadius = 10
        btn1ol.layer.borderWidth = 1
        btn1ol.layer.borderColor = UIColor.white.cgColor
        
        btn3ol.backgroundColor = UIColor.clear
        btn3ol.layer.cornerRadius = 5
        btn3ol.layer.borderWidth = 1
        btn3ol.layer.borderColor = UIColor.white.cgColor
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        catDobField.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(catDetailsController.dateChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard()"))
        
        
        

        
    }
    
    @IBAction func breedSelection(sender: UIButton) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.present(dest!, animated: true, completion: nil)
        
        
    }
    
    
    
    
    func dateChanged(datePicker: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        print("DATEFORMAT:\(dateFormatter.string(from: datePicker.date))")
        var newDateFormat = dateFormatter.string(from: datePicker.date)
        var newDateFormatYear = newDateFormat.substring(from: newDateFormat.index(newDateFormat.endIndex, offsetBy: -2))
        newDateFormat = String(newDateFormat.characters.dropLast())
        newDateFormat = String(newDateFormat.characters.dropLast())
        newDateFormat = String(newDateFormat.characters.dropLast())
        newDateFormatYear = newDateFormatYear + "/" +  newDateFormat
        print("NEWDATE: \(newDateFormatYear)")
        catDobField.text = newDateFormatYear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func uploadProfileImg(_ sender: UIButton) {
        
        
    }
    
    //continue btn
    @IBAction func btn3(_ sender: UIButton) {
        
        sender.layer.backgroundColor = UIColor(white: 1.0, alpha:0.1).cgColor
        
        createCatObj.user_id = floginobj.f_id
        createCatObj.name = catNameField.text!
        createCatObj.birthday = catDobField.text!
        createCatObj.initial_weight = catWeightField.text!
        createCatObj.breed_id = 1
        
        createCatObj.image_id = "xxx"
       
      
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
        createCatObj.gender = 0
        
        
    }
    
    //male btn
    @IBAction func btn2(_ sender: UIButton) {
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        
        btn1ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        createCatObj.gender = 1
        
    }
    
    @IBAction func neuteredSwitch(_ sender: UISwitch){
        if sender.isOn {
            yesNoLabel.text = "Yes"
             createCatObj.neutered = 1
        }else{
            yesNoLabel.text = "No"
             createCatObj.neutered = 0
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
   
    
    
    
    
}
