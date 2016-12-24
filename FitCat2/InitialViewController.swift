//
//  InitialViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {
    
    
    let gradient = CAGradientLayer()
    let welcomeLabel = UILabel()
    let loginButton = UIButton()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let lineBelowEmailTextField = CALayer()
    let footerLabel = UILabel()
    let incorrectEmailFooterLabel = InsetLabel()
    var isEmailValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradient()
        
        //Button set up
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        loginButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        loginButton.center.x = view.center.x
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 7
        loginButton.setTitle("Continue", for: .normal)
        loginButton.setTitleColor(.lightGray, for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
    
        //emailTextField set up
        emailTextField.frame =  CGRect(x: CGFloat(0), y: loginButton.frame.minY - 400.0, width: buttonWidth, height: CGFloat(buttonHeight) - 10.0)
        emailTextField.center.x = view.center.x
        emailTextField.textColor = .white
        emailTextField.returnKeyType = .continue
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Please Enter Your Email", attributes: [NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6)])
        emailTextField.delegate = self
        
        //email Label
        emailLabel.frame = emailTextField.frame
        emailLabel.center.y = emailTextField.center.y - emailTextField.bounds.height
        emailLabel.textColor = .white
        emailLabel.text = "Email"
        
        
        //welcome label
        welcomeLabel.text = "Welcome to FitCat"
        welcomeLabel.frame = loginButton.frame
        welcomeLabel.center.y = (emailLabel.frame.minY)/2.0
        welcomeLabel.center.x = view.center.x
        welcomeLabel.textColor = .white
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 36)
        welcomeLabel.sizeToFit()
        
        //white line below
        lineBelowEmailTextField.frame = CGRect(x: emailTextField.frame.minX, y: emailTextField.frame.maxY + 5.0, width: buttonWidth, height: 2.0)
        lineBelowEmailTextField.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        
        //footer label
        footerLabel.frame = CGRect(x: emailTextField.frame.minX, y: emailTextField.frame.maxY + 10.0, width: buttonWidth, height: 20.0)
        footerLabel.center.y = lineBelowEmailTextField.frame.maxY + (footerLabel.frame.height/2.0) + 10.0
        footerLabel.text = "Please Enter Your Email To Continue"
        footerLabel.textColor = .white
        footerLabel.sizeToFit()
        
   
        view.addSubview(loginButton)
        view.addSubview(welcomeLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailLabel)
        view.layer.addSublayer(lineBelowEmailTextField)
        view.addSubview(footerLabel)
        view.addSubview(incorrectEmailFooterLabel)

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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        
        lineBelowEmailTextField.backgroundColor = emailTextField.text?.characters.count == 0 ? UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor : UIColor.white.cgColor
        isEmailValid = emailTextField.text?.characters.count == 0 ? false : isValidEmail(testStr: emailTextField.text!)
        continueToNextScreen()
        return true
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func continueToNextScreen() {
        if !isEmailValid {
            //display invalid email error
            footerLabel.isHidden = true
            incorrectEmailFooterLabel.frame = footerLabel.frame
            incorrectEmailFooterLabel.text = "Oops. Please enter a valid email address."
            incorrectEmailFooterLabel.textColor = UIColor(red: 217.0/255.0, green: 73.0/255.0, blue: 55.0/255.0, alpha: 1.0)
            incorrectEmailFooterLabel.backgroundColor = .white
            incorrectEmailFooterLabel.adjustsFontSizeToFitWidth = true
            
            emailTextField.shake()
            
        } else {
            //check if email is in the system, if not show join page, if so show password screen
            footerLabel.isHidden = true
            incorrectEmailFooterLabel.isHidden = true
        }
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
