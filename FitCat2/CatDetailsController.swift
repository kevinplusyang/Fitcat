//
//  catDetailsController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class catDetailsController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let gradient = CAGradientLayer()
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catDobLabel: UILabel!
    @IBOutlet weak var catBreedLabel: UILabel!
    @IBOutlet weak var catWeightLabel: UILabel!
    @IBOutlet weak var catNeuteredLabel: UILabel!
    
    @IBOutlet weak var catProfileButton: UIButton!
    
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
    
    
    @IBOutlet weak var toggle: UISwitch!
    
    
    var standardDateFormat = ""
    var datePicker = UIDatePicker()
    var weightPicker = WeightPicker()
    var pounds = true
    var userId: Int?
    let userDefaults = UserDefaults.standard
    var gender = 1
    var imageString: String?
    var newCat: CreateCatModel!

    let lineBelowCatName = CALayer()
    let lineBelowDob = CALayer()
    let lineBelowBreed = CALayer()
    let lineBelowWeight = CALayer()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        userId = Int(userDefaults.string(forKey: "userID")!)!
        title = "Add A Cat"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        let xButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(cancelVC))
        self.navigationItem.setRightBarButton(xButton, animated: true)
        
        setUpGradient()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        //MARK: FIX FOR LATER
        pounds = userDefaults.value(forKey: "pounds") as! Bool
       
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
        btn3ol.frame = CGRect(x: btn3ol.frame.minX, y: btn3ol.frame.minY, width: btn3ol.frame.width, height: 55.0)
        
        //create done button for catDobField
        let doneToolbar = UIToolbar.init()
        doneToolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        doneToolbar.items = [flexSpace,doneButton]
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        catDobField.inputAccessoryView = doneToolbar
        catDobField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(catDetailsController.dateChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
        let weightToolbar = UIToolbar.init()
        weightToolbar.sizeToFit()
        weightPicker.catViewController = self
          let doneButtonWeight = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
       
        weightToolbar.items = [flexSpace,doneButtonWeight]
        catWeightField.inputAccessoryView = weightToolbar
        //MARK: FIX FOR LATER
        let isWeightPounds = userDefaults.value(forKey: "pounds") as! Bool
        weightPicker.isPounds = isWeightPounds
        catWeightField.inputView = weightPicker
        
        let margin = view.bounds.width * 0.08
        let spaceBelow = CGFloat(30.0)
        toggle.center.y = yesNoLabel.center.y
        
        
        lineBelowCatName.frame = CGRect(x: margin, y: (catNameLabel.frame.maxY + catDobLabel.frame.minY)/2.0, width: view.bounds.width - (margin * 2.0), height: 2.0)
        lineBelowCatName.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        lineBelowDob.frame = CGRect(x: margin, y: (catDobLabel.frame.maxY + catBreedLabel.frame.minY)/2.0, width: view.bounds.width - (margin * 2.0), height: 2.0)
        lineBelowDob.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        lineBelowBreed.frame = CGRect(x: margin, y: (catBreedLabel.frame.maxY + catWeightLabel.frame.minY)/2.0, width: view.bounds.width - (margin * 2.0), height: 2.0)
        lineBelowBreed.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        lineBelowWeight.frame = CGRect(x: margin, y: (catWeightLabel.frame.maxY + catNeuteredLabel.frame.minY)/2.0, width: view.bounds.width - (margin * 2.0), height: 2.0)
        lineBelowWeight.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor

        view.layer.addSublayer(lineBelowCatName)
        view.layer.addSublayer(lineBelowDob)
        view.layer.addSublayer(lineBelowBreed)
        view.layer.addSublayer(lineBelowWeight)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        updateGradient()
    }
    
    func cancelVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpGradient() {
        let topColor = UIColor(red: 240.0/255.0, green: 97.0/255.0, blue: 68.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 211.0/255.0, green: 61.0/255.0, blue: 43.0/255.0, alpha: 1.0).cgColor
        gradient.colors = [topColor,bottomColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    func updateGradient() {
        gradient.frame = view.bounds
        gradient.locations = [0.0,1.0]
    }

    
    func updateWeightDisplay() {
        catWeightField.text = pounds ? (weightPicker.poundsString + weightPicker.ouncesString) : (weightPicker.kilogramsString + weightPicker.gramsString)
    }

    @IBAction func breedSelection(sender: UIButton) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.present(dest!, animated: true, completion: nil)
    }
    
    func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        catDobField.text = dateFormatter.string(from: datePicker.date)
        
        //Server will accept the date format like yy/mm/dd
        dateFormatter.dateFormat = "yy/MM/dd"
        standardDateFormat = dateFormatter.string(from: datePicker.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func uploadProfileImg(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
             let localUrl = (info[UIImagePickerControllerMediaURL] ?? info[UIImagePickerControllerReferenceURL]!) as? NSURL
                print (localUrl!)
            imageString = String(describing: localUrl!)
            catProfileImg.image = image
            catProfileButton.setTitle("", for: .normal)
            
        } else {
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //continue btn
    @IBAction func btn3(_ sender: UIButton) {
        sender.layer.backgroundColor = UIColor(white: 1.0, alpha:0.1).cgColor

        if (catNameField.text?.isEmpty)! || (catDobField.text?.isEmpty)! || (catWeightField.text?.isEmpty)! {

            let alert = UIAlertController(title: "Error", message:"Oops, Some required fields have not been filled.", preferredStyle: .alert)
            let closeAction = UIAlertAction(title:"Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion:nil)
            
        } else {
            //The server will accept the following data format:
            // mm/dd/yy
        let isNeutered = toggle.isOn ? 1 : 0
        newCat = CreateCatModel()
        newCat.user_id = userId!
        newCat.name = catNameField.text!
        newCat.birthday = standardDateFormat
        newCat.breed_id = catBreedField.text!
        //MARK: CHECK IF WEIGHT IS IN POUNDS AND CONVERT TO KILOS
        print("CatWeightField is : \(catWeightField.text)")
        let stringOfWeight = catWeightField.text!
        print("Pounds of weight: \(stringOfWeight.getPounds())")
        newCat.initial_weight = "12.7"
        newCat.neutered = isNeutered
        newCat.gender = gender
        newCat.image_id = imageString!
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! selectBcsController
        destVC.newCat = newCat
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
        gender = 0
    }
    
    //male btn
    @IBAction func btn2(_ sender: UIButton) {
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        btn1ol.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        gender = 1
    }

    @IBAction func neuteredSwitch(_ sender: UISwitch){
        yesNoLabel.text = sender.isOn ? "Yes" : "No"
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

