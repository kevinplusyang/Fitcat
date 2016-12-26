//
//  PreferencesViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/26/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    let gradient = CAGradientLayer()
    let preferencesLabel = UILabel()
    let startFitCatButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradient()
        self.navigationItem.title = ""
        //Button set up
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
        
        
        //emailTextField set up
        let startOfTextView = view.bounds.height * 0.20
        let endOfTextView = startFitCatButton.frame.minY - 35.0
        
        
        
        
        //welcome label
        preferencesLabel.text = "Preferences"
        preferencesLabel.frame = startFitCatButton.frame
        preferencesLabel.center.y = view.bounds.height * 0.15
        preferencesLabel.center.x = view.center.x
        preferencesLabel.textColor = .white
        preferencesLabel.font = UIFont.boldSystemFont(ofSize: 30)
        preferencesLabel.sizeToFit()
        
        
        
        
        view.addSubview(startFitCatButton)
        view.addSubview(preferencesLabel)
        
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
