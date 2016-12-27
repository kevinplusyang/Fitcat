//
//  PreferencesViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/26/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    let data = UserDefaults.standard
    let gradient = CAGradientLayer()
    let preferencesLabel = UILabel()
    let startFitCatButton = UIButton()
    let unitsOfMeasurementLabel = UILabel()
    let poundsButton = UIButton()
    let kilogramsButton = UIButton()
    let lineBelowButtons = CALayer()
    let remindMeOfDailyFeedingLabel = UILabel()
    let remindMeOfDailyFeedingToggle = UISwitch()
    let remindMeOfDailyFeedingToggleLabel = UILabel()
    let lineBelowDailyFeeding = CALayer()
    let remindMeWhenPlanGoesWrongLabel = UILabel()
    let remindMeWhenPlanGoesWrongToggle = UISwitch()
    let remindMeWhenPlanGoesWrongToggleLabel = UILabel()
    let lineBelowPlanGoesWrong = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGradient()
        self.navigationItem.title = ""
        
        //Start FitCat Button
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        startFitCatButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        startFitCatButton.center.x = view.center.x
        startFitCatButton.layer.borderWidth = 2.0
        startFitCatButton.layer.borderColor = UIColor.white.cgColor
        startFitCatButton.layer.cornerRadius = 7
        startFitCatButton.setTitle("Start FitCat", for: .normal)
        startFitCatButton.setTitleColor(.lightGray, for: .highlighted)
        startFitCatButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        //Preferences Label
        preferencesLabel.text = "Preferences"
        preferencesLabel.frame = startFitCatButton.frame
        preferencesLabel.center.y = view.bounds.height * 0.15
        preferencesLabel.center.x = view.center.x
        preferencesLabel.textColor = .white
        preferencesLabel.font = UIFont.boldSystemFont(ofSize: 30)
        preferencesLabel.sizeToFit()
        
        //MARK: Start and End of Main Content and Space Between Elements
        let startOfContent = preferencesLabel.frame.maxY + (preferencesLabel.frame.maxY * 0.20)
        let endOfContent = startFitCatButton.frame.minY - (startFitCatButton.frame.minY * 0.15)
        let spaceBetweenElements = (endOfContent - startOfContent) / 10.0
        
        //MARK: Units of Measurment Section
        
        //Units of Measurment Label
        unitsOfMeasurementLabel.frame = CGRect(x: preferencesLabel.frame.minX, y: startOfContent, width: 60, height: 10)
        unitsOfMeasurementLabel.text = "Units of Measurement:"
        unitsOfMeasurementLabel.textColor = .white
        unitsOfMeasurementLabel.sizeToFit()
        
        //Pounds/Kilograms Button Constants
        let buttonWidths = view.bounds.width * 0.30
        let spaceBetweenButtons = view.bounds.width * 0.20
        let buttonsMargin = view.bounds.width * 0.10
        let startOfButtons = unitsOfMeasurementLabel.frame.maxY + spaceBetweenElements
        poundsButton.frame = CGRect(x: buttonsMargin, y: startOfButtons, width: buttonWidths, height: 40.0)
        
        //Pounds Button
        poundsButton.setTitle("Pounds", for: .normal)
        poundsButton.setTitleColor(.white, for: .normal)
        poundsButton.addTarget(self, action: #selector(unitsOfMeasurementPressed(sender:)), for: .touchUpInside)
        poundsButton.tag = 101
        poundsButton.layer.borderColor = UIColor.white.cgColor
        poundsButton.layer.cornerRadius = poundsButton.bounds.height/2.0
        
        //Kilograms Button
        kilogramsButton.frame = CGRect(x: poundsButton.frame.maxX + spaceBetweenButtons, y: startOfButtons, width: buttonWidths, height: 40.0)
        kilogramsButton.setTitle("Kilograms", for: .normal)
        kilogramsButton.setTitleColor(.white, for: .normal)
        kilogramsButton.addTarget(self, action: #selector(unitsOfMeasurementPressed(sender:)), for: .touchUpInside)
        kilogramsButton.layer.borderColor = UIColor.white.cgColor
        kilogramsButton.layer.cornerRadius = poundsButton.bounds.height/2.0
        
        //Line Below Buttons
        lineBelowButtons.frame = CGRect(x: preferencesLabel.frame.minX, y: poundsButton.frame.maxY + spaceBetweenElements, width: view.bounds.width - (preferencesLabel.frame.minX * 2.0), height: 2.0)
        lineBelowButtons.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        //MARK: Daily Feeding Section
        
        //Daily Feeding Label
        remindMeOfDailyFeedingLabel.frame = CGRect(x: preferencesLabel.frame.minX, y: lineBelowButtons.frame.maxY + spaceBetweenElements, width: 100.0, height: 10.0)
        remindMeOfDailyFeedingLabel.text = "Remind me of daily feedings:"
        remindMeOfDailyFeedingLabel.textColor = .white
        remindMeOfDailyFeedingLabel.sizeToFit()
        
        //Daily Feeding Toggle
        let dailyFeedingToggleWidth = remindMeOfDailyFeedingToggle.bounds.width
        let dailyFeedingToggleHeight = remindMeOfDailyFeedingToggle.bounds.height
        remindMeOfDailyFeedingToggle.isOn = true
        remindMeOfDailyFeedingToggle.onTintColor = .clear
        remindMeOfDailyFeedingToggle.frame = CGRect(x: lineBelowButtons.frame.maxX - dailyFeedingToggleWidth, y: remindMeOfDailyFeedingLabel.frame.maxY + (spaceBetweenElements/2.0), width: dailyFeedingToggleWidth, height: dailyFeedingToggleHeight)
        remindMeOfDailyFeedingToggle.addTarget(self, action: #selector(dailyFeedingTogglePressed(sender:)), for: .primaryActionTriggered)
        remindMeOfDailyFeedingToggle.layer.borderWidth = 1.5
        remindMeOfDailyFeedingToggle.layer.borderColor = UIColor.white.cgColor
        remindMeOfDailyFeedingToggle.layer.cornerRadius = dailyFeedingToggleHeight/2.0
        
        //Daily Feeding Yes/No Label
        remindMeOfDailyFeedingToggleLabel.text = "Yes"
        remindMeOfDailyFeedingToggleLabel.textColor = .white
        remindMeOfDailyFeedingToggleLabel.frame = CGRect(x: remindMeOfDailyFeedingToggle.frame.minX - 40.0, y: 0.0, width: 30.0, height: 10.0)
        remindMeOfDailyFeedingToggleLabel.center.y = remindMeOfDailyFeedingToggle.center.y
        remindMeOfDailyFeedingToggleLabel.sizeToFit()
        
        //Line Below Plan Goes Wrong Section
        lineBelowDailyFeeding.frame = CGRect(x: preferencesLabel.frame.minX, y: remindMeOfDailyFeedingToggle.frame.maxY + (spaceBetweenElements/2.0), width: view.bounds.width - (preferencesLabel.frame.minX * 2.0), height: 2.0)
        lineBelowDailyFeeding.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        //MARK: Plan Goes Wrong Section
        
        //Plan Goes Wrong Label
        remindMeWhenPlanGoesWrongLabel.frame = CGRect(x: preferencesLabel.frame.minX, y: lineBelowDailyFeeding.frame.maxY + spaceBetweenElements, width: 100.0, height: 10.0)
        remindMeWhenPlanGoesWrongLabel.text = "Notify me if plan goes wrong:"
        remindMeWhenPlanGoesWrongLabel.textColor = .white
        remindMeWhenPlanGoesWrongLabel.sizeToFit()
        
        //Plan Goes Wrong Toggle
        let planGoesWrongToggleWidth = remindMeWhenPlanGoesWrongToggle.bounds.width
        let planGoesWrongToggleHeight = remindMeWhenPlanGoesWrongToggle.bounds.height
        remindMeWhenPlanGoesWrongToggle.isOn = true
        remindMeWhenPlanGoesWrongToggle.onTintColor = .clear
        remindMeWhenPlanGoesWrongToggle.frame = CGRect(x: lineBelowDailyFeeding.frame.maxX - dailyFeedingToggleWidth, y: remindMeWhenPlanGoesWrongLabel.frame.maxY + (spaceBetweenElements/2.0), width: planGoesWrongToggleWidth, height: planGoesWrongToggleHeight)
        remindMeWhenPlanGoesWrongToggle.addTarget(self, action: #selector(planGoesWrongTogglePressed(sender:)), for: .primaryActionTriggered)
        remindMeWhenPlanGoesWrongToggle.layer.borderWidth = 1.5
        remindMeWhenPlanGoesWrongToggle.layer.borderColor = UIColor.white.cgColor
        remindMeWhenPlanGoesWrongToggle.layer.cornerRadius = dailyFeedingToggleHeight/2.0
        
        //Plan Goes Wrong Yes/No Label
        remindMeWhenPlanGoesWrongToggleLabel.text = "Yes"
        remindMeWhenPlanGoesWrongToggleLabel.textColor = .white
        remindMeWhenPlanGoesWrongToggleLabel.frame = CGRect(x: remindMeWhenPlanGoesWrongToggle.frame.minX - 40.0, y: 0.0, width: 30.0, height: 10.0)
        remindMeWhenPlanGoesWrongToggleLabel.center.y = remindMeWhenPlanGoesWrongToggle.center.y
        remindMeWhenPlanGoesWrongToggleLabel.sizeToFit()
        
        //Line Below Plan Goes Wrong Section
        lineBelowPlanGoesWrong.frame = CGRect(x: preferencesLabel.frame.minX, y: remindMeWhenPlanGoesWrongToggle.frame.maxY + (spaceBetweenElements/2.0), width: view.bounds.width - (preferencesLabel.frame.minX * 2.0), height: 2.0)
        lineBelowPlanGoesWrong.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        
        //Set Defaults
        unitsOfMeasurementPressed(sender: poundsButton)
        dailyFeedingTogglePressed(sender: remindMeOfDailyFeedingToggle)
        planGoesWrongTogglePressed(sender: remindMeWhenPlanGoesWrongToggle)

        //Add all Buttons/Labels/Toggles to View
        view.addSubview(startFitCatButton)
        view.addSubview(preferencesLabel)
        view.addSubview(unitsOfMeasurementLabel)
        view.addSubview(poundsButton)
        view.addSubview(kilogramsButton)
        view.addSubview(remindMeOfDailyFeedingLabel)
        view.addSubview(remindMeOfDailyFeedingToggle)
        view.addSubview(remindMeOfDailyFeedingToggleLabel)
        view.addSubview(remindMeWhenPlanGoesWrongLabel)
        view.addSubview(remindMeWhenPlanGoesWrongToggle)
        view.addSubview(remindMeWhenPlanGoesWrongToggleLabel)
        
        //Add Dividers
        view.layer.addSublayer(lineBelowButtons)
        view.layer.addSublayer(lineBelowDailyFeeding)
        view.layer.addSublayer(lineBelowPlanGoesWrong)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        updateGradient()
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
    
    func loginButtonPressed() {
        continueToNextScreen()
    }
    
    
    func continueToNextScreen() {
        //Fix this so it goes to catCardVC
        //let mainVC = catCardsViewController()
        //present(mainVC, animated: true, completion: nil)
        //let createACatVC = catDetailsController()
        //present(createACatVC, animated: true, completion: nil)
        let dest = storyboard?.instantiateViewController(withIdentifier: "createCatView")
        present(dest!, animated: true, completion: nil)
    }
    
    func unitsOfMeasurementPressed(sender: UIButton) {
        let isPoundsButton = sender.tag == 101
        data.set(isPoundsButton, forKey: "pounds")
        
        poundsButton.layer.borderWidth = isPoundsButton ? 2.0 : 0.0
        poundsButton.backgroundColor = isPoundsButton ? UIColor(white: 1.0, alpha: 0.3) : .clear
        
        kilogramsButton.layer.borderWidth = isPoundsButton ? 0.0 : 2.0
        kilogramsButton.backgroundColor = isPoundsButton ? .clear : UIColor(white: 1.0, alpha: 0.3)
        
    }
    
    func dailyFeedingTogglePressed(sender: UISwitch) {
        data.set(sender.isOn, forKey: "remindDailyFeedings")
        remindMeOfDailyFeedingToggleLabel.text = sender.isOn ? "Yes" : "No"
        
        //if true, set daily notifications etc
    }
    
    func planGoesWrongTogglePressed(sender: UISwitch) {
        data.set(sender.isOn, forKey: "remindPlanWrong")
        remindMeWhenPlanGoesWrongToggleLabel.text = sender.isOn ? "Yes" : "No"
        //if true, set up notifs stuff to see if plan goes wrong
    }    
}
