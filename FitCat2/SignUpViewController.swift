//
//  SignUpViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    let gradient = CAGradientLayer()
    let signUpLabel = UILabel()
    let createAccountButton = UIButton()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let lineBelowPasswordTextField = CALayer()
    let footerLabel = UILabel()
    let incorrectPasswordFooterLabel = InsetLabel()
    var isPasswordValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradient()
        
        //Button set up
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        createAccountButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        createAccountButton.center.x = view.center.x
        createAccountButton.layer.borderWidth = 2.0
        createAccountButton.layer.borderColor = UIColor.white.cgColor
        createAccountButton.layer.cornerRadius = 7
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.lightGray, for: .highlighted)
        createAccountButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        
        //passwordTextField set up
        passwordTextField.frame =  CGRect(x: CGFloat(0), y: createAccountButton.frame.minY - view.frame.midY, width: buttonWidth, height: CGFloat(buttonHeight) - 10.0)
        passwordTextField.center.x = view.center.x
        passwordTextField.textColor = .white
        passwordTextField.returnKeyType = .continue
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Please Create A Password", attributes: [NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6)])
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        //password Label
        passwordLabel.frame = passwordTextField.frame
        passwordLabel.center.y = passwordTextField.center.y - passwordTextField.bounds.height
        passwordLabel.textColor = .white
        passwordLabel.text = "Password"
        
        
        //sign up label
        signUpLabel.text = "Sign Up"
        signUpLabel.frame = createAccountButton.frame
        signUpLabel.center.y = (passwordLabel.frame.minY)/2.0
        signUpLabel.center.x = view.center.x
        signUpLabel.textColor = .white
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 30)
        signUpLabel.sizeToFit()
        
        //white line below
        lineBelowPasswordTextField.frame = CGRect(x: passwordTextField.frame.minX, y: passwordTextField.frame.maxY + 5.0, width: buttonWidth, height: 2.0)
        lineBelowPasswordTextField.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        
        //footer label
        footerLabel.frame = CGRect(x: passwordTextField.frame.minX, y: passwordTextField.frame.maxY + 10.0, width: buttonWidth, height: 20.0)
        footerLabel.center.y = lineBelowPasswordTextField.frame.maxY + (footerLabel.frame.height/2.0) + 10.0
        footerLabel.text = "Your Password Must Be 8 Characters Or Longer"
        footerLabel.textColor = .white
        footerLabel.adjustsFontSizeToFitWidth = true
        
        
        view.addSubview(createAccountButton)
        view.addSubview(signUpLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordLabel)
        view.layer.addSublayer(lineBelowPasswordTextField)
        view.addSubview(footerLabel)
        view.addSubview(incorrectPasswordFooterLabel)
        
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
        passwordTextField.resignFirstResponder()
        
        lineBelowPasswordTextField.backgroundColor = passwordTextField.text?.characters.count == 0 ? UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor : UIColor.white.cgColor
        isPasswordValid = passwordTextField.text?.characters.count == 0 ? false : isValidPassword(testStr: passwordTextField.text!)
        continueToNextScreen()
        return true
    }
    
    
    func isValidPassword(testStr:String) -> Bool {
        return testStr.characters.count >= 8
    }
    
    func continueToNextScreen() {
        if !isPasswordValid {
            //display invalid email error
            footerLabel.isHidden = true
            incorrectPasswordFooterLabel.frame = footerLabel.frame
            incorrectPasswordFooterLabel.text = "Oops. Please enter a valid password"
            incorrectPasswordFooterLabel.textColor = UIColor(red: 217.0/255.0, green: 73.0/255.0, blue: 55.0/255.0, alpha: 1.0)
            incorrectPasswordFooterLabel.backgroundColor = .white
            incorrectPasswordFooterLabel.adjustsFontSizeToFitWidth = true
            passwordTextField.shake()
            
        } else {
            //check if email is in the system, if not show join page, if so show password screen
            footerLabel.isHidden = true
            incorrectPasswordFooterLabel.isHidden = true
            let tosVC = TermsOfServiceViewController()
            navigationController?.pushViewController(tosVC, animated: true)
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
