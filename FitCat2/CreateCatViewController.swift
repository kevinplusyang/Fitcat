//
//  CreateCatViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire



class CreateCatViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, RSKImageCropViewControllerDelegate {

    let gradient = CAGradientLayer()
    let imagePicker = UIImagePickerController()
    let catNameLabel = UILabel()
    let catDobLabel = UILabel()
    let catBreedLabel = UILabel()
    let catWeightLabel = UILabel()
    let catNeuteredLabel = UILabel()
    let yesNoLabel = UILabel()
    let catProfileImageView = UIImageView()
    let catNameField = UITextField()
    let catDobField = UITextField()
    let catBreedField = UITextField()
    let catWeightField = UITextField()
    let toggle = UISwitch()
    let maleButton = UIButton()
    let femaleButton = UIButton()
    let continueButton = UIButton()
    let addLabel = UILabel()
    var activeTextField: UITextField!

    var scrollView: UIScrollView!
    var standardDateFormat = Date()
    var datePicker = UIDatePicker()
    var weightPicker = WeightPicker()
    var pounds = true
    let userDefaults = UserDefaults.standard
    var imageString: String?
    let lineBelowCatName = CALayer()
    let lineBelowDob = CALayer()
    let lineBelowBreed = CALayer()
    let lineBelowWeight = CALayer()
    let lineBelowNeuter = CALayer()

    let backgroundLineBelowTopButtons = CALayer()

    let photoGesture = UITapGestureRecognizer()

    //New Cat Parameters
    var catImageData: Data?
    var catName: String?
    var catBirthday: Date?
    var catBreed: String?
    var catWeight: Double?
    var catNeutered: Int? //0 is False, 1 is True
    var catGender: Int = 1 //1 is male, 2 is female

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarView?.tintColor = .fitcatOrange
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 240/255, green: 97/255, blue: 68/255, alpha: 1.0)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        scrollView.contentSize = view.bounds.size
        scrollView.autoresizingMask = .flexibleHeight
        title = "Add A Cat"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        let xButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(cancelVC))
        self.navigationItem.setRightBarButton(xButton, animated: true)

        setUpGradient()
        setUpView()

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        //MARK: FIX FOR LATER
        guard let poundsUserDefault = userDefaults.value(forKey: "pounds") as? Bool else {
            return
        }
        pounds = poundsUserDefault

        // Do any additional setup after loading the view, typically from a nib.
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
        datePicker.addTarget(self, action: #selector(CreateCatViewController.dateChanged(datePicker:)), for: UIControlEvents.valueChanged)

        let weightToolbar = UIToolbar.init()
        weightToolbar.sizeToFit()
        weightPicker.catViewController = self
        let doneButtonWeight = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(updateWeightDisplay))

        weightToolbar.items = [flexSpace,doneButtonWeight]
        catWeightField.inputAccessoryView = weightToolbar

        //MARK: FIX FOR LATER
        guard let isWeightPounds = userDefaults.value(forKey: "pounds") as? Bool else {
            return
        }
        pounds = isWeightPounds
        weightPicker.isPounds = isWeightPounds
        catWeightField.inputView = weightPicker

        view.addSubview(scrollView)

    }

    override func viewDidLayoutSubviews() {
        updateGradient()
    }

    func cancelVC() {
        UIApplication.shared.statusBarView?.backgroundColor = .fitcatGray
        dismiss(animated: true, completion: {

        })
    }

    func setUpGradient() {
        let topColor = UIColor(red: 240.0/255.0, green: 97.0/255.0, blue: 68.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 211.0/255.0, green: 61.0/255.0, blue: 43.0/255.0, alpha: 1.0).cgColor
        gradient.colors = [topColor, bottomColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    func updateGradient() {
        gradient.frame = view.bounds
        gradient.locations = [0.0, 1.0]
    }

    func setUpView() {

        //Button set up
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        continueButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        continueButton.center.x = view.center.x
        continueButton.layer.borderWidth = 2.0
        continueButton.layer.borderColor = UIColor.white.cgColor
        continueButton.layer.cornerRadius = 7
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.lightGray, for: .highlighted)
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        scrollView.addSubview(continueButton)

        let widthOfButtons = view.bounds.width * 0.22


        let viewHeight = view.bounds.height
        catProfileImageView.frame = CGRect(x: 0, y: 10, width: viewHeight * 0.125, height: viewHeight * 0.125)
        catProfileImageView.center.x = view.center.x
        //cat profile image UI: round images
        catProfileImageView.layer.borderWidth = 1
        catProfileImageView.layer.masksToBounds = false
        catProfileImageView.layer.borderColor = UIColor.white.cgColor
        catProfileImageView.layer.cornerRadius = catProfileImageView.frame.height/2
        catProfileImageView.clipsToBounds = true
        catProfileImageView.isUserInteractionEnabled = true
        photoGesture.addTarget(self, action: #selector(tappedPhotos))

        catProfileImageView.addGestureRecognizer(photoGesture)
        //label for adding photo
        addLabel.textColor = .white
        addLabel.text = "Add"
        addLabel.alpha = 0.4
        addLabel.sizeToFit()
        addLabel.center = catProfileImageView.center


        scrollView.addSubview(catProfileImageView)
        scrollView.addSubview(addLabel)

        let contentTop = catProfileImageView.frame.maxY
        let contentBottom = continueButton.frame.minY - 40.0
        let spaceBetweenEachItem = (contentBottom - contentTop) / 11.0
        let labelInset = view.bounds.width * 0.08

        let labelArray = [catNameLabel, catDobLabel, catBreedLabel, catWeightLabel, catNeuteredLabel]

        //Cat Name Label
        catNameLabel.frame = CGRect(x: labelInset, y: catProfileImageView.frame.maxY + 20.0, width: 20, height: 5)
        catNameLabel.text = "Name"
        catNameLabel.textColor = .white
        catNameLabel.sizeToFit()

        lineBelowCatName.frame = CGRect(x: labelInset, y: catNameLabel.frame.maxY + 15.0, width: view.bounds.width - (labelInset * 2.0), height: 2.0)
        lineBelowCatName.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor

        catDobLabel.frame = CGRect(x: labelInset, y: lineBelowCatName.frame.maxY + spaceBetweenEachItem, width: 20, height: 5)
        catDobLabel.text = "Date of Birth"
        catDobLabel.textColor = .white
        catDobLabel.sizeToFit()

        lineBelowDob.frame = CGRect(x: labelInset, y: catDobLabel.frame.maxY + 15.0, width: view.bounds.width - (labelInset * 2.0), height: 2.0)
        lineBelowDob.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor

        catBreedLabel.frame = CGRect(x: labelInset, y: lineBelowDob.frame.maxY + spaceBetweenEachItem, width: 20, height: 5)
        catBreedLabel.text = "Breed"
        catBreedLabel.textColor = .white
        catBreedLabel.sizeToFit()

        lineBelowBreed.frame = CGRect(x: labelInset, y: catBreedLabel.frame.maxY + 15.0, width: view.bounds.width - (labelInset * 2.0), height: 2.0)
        lineBelowBreed.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor

        catWeightLabel.frame = CGRect(x: labelInset, y: lineBelowBreed.frame.maxY + spaceBetweenEachItem, width: 20, height: 5)
        catWeightLabel.text = "Weight"
        catWeightLabel.textColor = .white
        catWeightLabel.sizeToFit()

        lineBelowWeight.frame = CGRect(x: labelInset, y: catWeightLabel.frame.maxY + 15.0, width: view.bounds.width - (labelInset * 2.0), height: 2.0)
        lineBelowWeight.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor

        catNeuteredLabel.frame = CGRect(x: labelInset, y: lineBelowWeight.frame.maxY + spaceBetweenEachItem, width: 20, height: 5)
        catNeuteredLabel.text = "Neutered/Spayed"
        catNeuteredLabel.textColor = .white
        catNeuteredLabel.sizeToFit()
        lineBelowNeuter.frame = CGRect(x: labelInset, y: catNeuteredLabel.frame.maxY + 15.0, width: view.bounds.width - (labelInset * 2.0), height: 2.0)
        lineBelowNeuter.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor


        catNameLabel.alpha = 0.4
        catDobLabel.alpha = 0.4
        catBreedLabel.alpha = 0.4
        catWeightLabel.alpha = 0.4
        catNeuteredLabel.alpha = 0.4

        for i in labelArray {
            scrollView.addSubview(i)
        }

        scrollView.layer.addSublayer(lineBelowCatName)
        scrollView.layer.addSublayer(lineBelowDob)
        scrollView.layer.addSublayer(lineBelowBreed)
        scrollView.layer.addSublayer(lineBelowWeight)
        scrollView.layer.addSublayer(lineBelowNeuter)

        let widthOfTextFields = view.bounds.width - (catDobLabel.frame.maxX + 10.0) - labelInset

        catNameField.frame = CGRect(x: catDobLabel.frame.maxX + 10.0, y: catNameLabel.frame.minY, width: widthOfTextFields, height: catNameLabel.bounds.height)
        catNameField.placeholder = "Cat Name"
        catNameField.returnKeyType = .done
        catNameField.center.y = catNameLabel.center.y
        catNameField.textColor = .white

        catDobField.frame = CGRect(x: catDobLabel.frame.maxX + 10.0, y: catDobLabel.frame.minY, width: widthOfTextFields, height: catNameLabel.bounds.height)
        catDobField.placeholder = "Birthday"
        catDobField.returnKeyType = .done
        catDobField.center.y = catDobLabel.center.y
        catDobField.textColor = .white

        catBreedField.frame = CGRect(x: catDobLabel.frame.maxX + 10.0, y: catBreedLabel.frame.minY, width: widthOfTextFields, height: catNameLabel.bounds.height)
        catBreedField.placeholder = "Breed"
        catBreedField.returnKeyType = .done
        catBreedField.center.y = catBreedLabel.center.y
        catBreedField.textColor = .white

        catWeightField.frame = CGRect(x: catDobLabel.frame.maxX + 10.0, y: catWeightLabel.frame.minY, width: widthOfTextFields, height: catNameLabel.bounds.height)
        catWeightField.placeholder = "Weight"
        catWeightField.returnKeyType = .done
        catWeightField.center.y = catWeightLabel.center.y
        catWeightField.textColor = .white

        let toggleWidth = toggle.bounds.width
        toggle.frame = CGRect(x: view.bounds.width - toggleWidth - labelInset, y: catNeuteredLabel.frame.minY, width: toggleWidth, height: toggle.bounds.height)
        toggle.center.y = catNeuteredLabel.center.y
        toggle.isOn = true
        toggle.addTarget(self, action: #selector(didToggle), for: .valueChanged)

        yesNoLabel.text = "Yes"
        yesNoLabel.textColor = .white
        yesNoLabel.sizeToFit()
        yesNoLabel.frame = CGRect(x: toggle.frame.minX - yesNoLabel.frame.width - 5.0, y: catNeuteredLabel.frame.minY, width: yesNoLabel.bounds.width, height: yesNoLabel.bounds.height)
        yesNoLabel.center.y = toggle.center.y

        //Male/Female Buttons
        maleButton.backgroundColor = UIColor.clear
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor.white.cgColor
        maleButton.setTitle("Male", for: .normal)
        maleButton.setTitleColor(.white, for: .normal)
        maleButton.setTitleColor(.lightGray, for: .highlighted)

        femaleButton.backgroundColor = UIColor.clear
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor.clear.cgColor
        femaleButton.setTitle("Female", for: .normal)
        femaleButton.setTitleColor(.white, for: .normal)
        femaleButton.setTitleColor(.lightGray, for: .highlighted)
        femaleButton.alpha = 0.4

        femaleButton.layer.cornerRadius = femaleButton.bounds.height / 2.0
        maleButton.layer.cornerRadius = maleButton.bounds.height / 2.0

        let combinedWidthWithSpacing = (widthOfButtons * 2.0) + 30.0
        let indentationOfButtons = (view.bounds.width - combinedWidthWithSpacing) / 2.0
        let centerForButtons = (continueButton.frame.minY - lineBelowNeuter.frame.maxY) / 2.0 + (lineBelowNeuter.frame.maxY)

        maleButton.frame = CGRect(x: indentationOfButtons, y: catNeuteredLabel.frame.maxY + 30.0, width: widthOfButtons, height: 26.0)
        femaleButton.frame = CGRect(x: maleButton.frame.maxX + 30.0, y: catNeuteredLabel.frame.maxY + 30.0, width: widthOfButtons, height: 26.0)
        maleButton.layer.cornerRadius = maleButton.bounds.height / 2.0
        femaleButton.layer.cornerRadius = femaleButton.bounds.height / 2.0
        femaleButton.center.y = centerForButtons
        maleButton.center.y = centerForButtons

        maleButton.addTarget(self, action: #selector(clickedButtonTest), for: .touchUpInside)
        maleButton.tag = 2
        femaleButton.addTarget(self, action: #selector(clickedButtonTest), for: .touchUpInside)
        femaleButton.tag = 3


        catNameField.delegate = self
        catBreedField.delegate = self

        scrollView.addSubview(catNameField)
        scrollView.addSubview(catDobField)
        scrollView.addSubview(catBreedField)
        scrollView.addSubview(catWeightField)
        scrollView.addSubview(toggle)
        scrollView.addSubview(yesNoLabel)
        scrollView.addSubview(maleButton)
        scrollView.addSubview(femaleButton)




    }

    func didToggle(sender: UISwitch) {
        yesNoLabel.text = sender.isOn ? "Yes" : "No"
    }

    func tappedPhotos(sender: UIGestureRecognizer) {
        self.present(imagePicker, animated: true, completion: {
            UIApplication.shared.statusBarView?.backgroundColor = .clear
        })
    }

    func updateWeightDisplay() {
        catWeightField.text = pounds ? (weightPicker.poundsString + weightPicker.ouncesString) : (weightPicker.kilogramsString + weightPicker.gramsString)
        dismissKeyboard()
    }



    func continueButtonPressed(sender: UIButton) {
        if (catNameField.text?.isEmpty)! || (catDobField.text?.isEmpty)! || (catWeightField.text?.isEmpty)! {

            let alert = UIAlertController(title: "Error", message:"Oops, Some required fields have not been filled.", preferredStyle: .alert)
            let closeAction = UIAlertAction(title:"Close", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion:nil)

        } else {
            //The server will accept the following data format:
            // mm/dd/yy
            let isNeutered = toggle.isOn ? 1 : 0
            catName = catNameField.text!
            catBirthday = standardDateFormat
            catBreed = catBreedField.text!

            //MARK: CHECK IF WEIGHT IS IN POUNDS AND CONVERT TO KILOS
            let stringOfWeight = catWeightField.text!
            var initial_weight_parsed = 0.0
            if pounds {
                let pounds = Double(stringOfWeight.getPounds())
                let ounces = Double(stringOfWeight.getOunces())
                let combinedOunces = (pounds?.poundsToOunces())! + ounces!
                initial_weight_parsed = combinedOunces.ouncesToKilograms()
            }

            catWeight = initial_weight_parsed
            catNeutered = isNeutered

            let bcsVC = SelectBcsController()
            bcsVC.catImageData = catImageData
            bcsVC.catGender = catGender
            bcsVC.catNeutered = catNeutered
            bcsVC.catWeight = catWeight
            bcsVC.catBreed = catBreed
            bcsVC.catBirthday = catBirthday
            bcsVC.catName = catName
            navigationController?.pushViewController(bcsVC, animated: true)
            //present(vc, animated: true, completion: nil)

        }

    }

    func clickedButtonTest(sender: UIButton!) {
        let tag = sender.tag
        maleButton.layer.borderColor = tag == 2 ? UIColor.white.cgColor : UIColor.clear.cgColor
        maleButton.alpha = tag == 2 ? 1.0 : 0.4
        femaleButton.layer.borderColor = tag == 3 ? UIColor.white.cgColor : UIColor.clear.cgColor
        femaleButton.alpha = tag == 3 ? 1.0 : 0.4
        catGender = tag == 2 ? 1 : 2
    }

    @IBAction func breedSelection(sender: UIButton) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.present(dest!, animated: true, completion: nil)
    }

    func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        catDobField.text = dateFormatter.string(from: datePicker.date)
        let dateString = dateFormatter.string(from: datePicker.date)
        //Server will accept the date format like yy/mm/dd
        //dateFormatter.dateFormat = "yy/MM/dd"
        standardDateFormat = dateFormatter.date(from: dateString)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func uploadProfileImg(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var catImage: UIImage!
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let localUrl = (info[UIImagePickerControllerMediaURL] ?? info[UIImagePickerControllerReferenceURL]!) as? NSURL
            imageString = String(describing: localUrl!)
            catImage = image
            addLabel.text = ""


        } else {
            print("Something went wrong")
        }


        displayCropper(image: catImage)
    }

    func displayCropper(image: UIImage) {
        let imageCropVC = RSKImageCropViewController(image: image)
        imageCropVC.delegate = self
        imagePicker.pushViewController(imageCropVC, animated: true)


    }


    @IBAction func touchCancel(_ sender: UIButton){
        sender.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
    }

    @IBAction func neuteredSwitch(_ sender: UISwitch){
        yesNoLabel.text = sender.isOn ? "Yes" : "No"
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //for textField in self.view.subviews where textField is UITextField {
        //    textField.resignFirstResponder()
        //}
        textField.resignFirstResponder()
        dismissKeyboard()
        return true
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        catProfileImageView.image = croppedImage
        let data = UIImageJPEGRepresentation(croppedImage, 0.9)
        catImageData = data!
        //imagePicker.dismiss(animated: false, completion: {
        //UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 240/255, green: 97/255, blue: 68/255, alpha: 1.0)
        //})
        dismiss(animated: true, completion: {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 240/255, green: 97/255, blue: 68/255, alpha: 1.0)
        })
    }

    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        //navigationController?.popViewController(animated: true)
        imagePicker.popViewController(animated: true)

    }
}


