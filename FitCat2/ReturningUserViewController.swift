//
//  ReturningUserViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/26/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire

class ReturningUserViewController: UIViewController, UITextFieldDelegate {
    
    var userEmail = ""
    var userPassword = ""
    let gradient = CAGradientLayer()
    let loginLabel = UILabel()
    let loginButton = UIButton()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let lineBelowPasswordTextField = CALayer()
    let footerLabel = UILabel()
    let incorrectPasswordFooterLabel = InsetLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradient()
        self.navigationItem.title = ""
        
        //Login Button Set Up
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        loginButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        loginButton.center.x = view.center.x
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 7
        loginButton.setTitle("Welcome Back!", for: .normal)
        loginButton.setTitleColor(.lightGray, for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        
        //PasswordTextField Set Up
        passwordTextField.frame =  CGRect(x: CGFloat(0), y: loginButton.frame.minY - view.frame.midY, width: buttonWidth, height: CGFloat(buttonHeight) - 10.0)
        passwordTextField.center.x = view.center.x
        passwordTextField.textColor = .white
        passwordTextField.returnKeyType = .continue
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Please Enter Your Password", attributes: [NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6)])
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        //Password Label
        passwordLabel.frame = passwordTextField.frame
        passwordLabel.center.y = passwordTextField.center.y - passwordTextField.bounds.height
        passwordLabel.textColor = .white
        passwordLabel.text = "Password"
        
        
        //Login Label
        loginLabel.text = "Log In"
        loginLabel.frame = loginButton.frame
        loginLabel.center.y = (passwordLabel.frame.minY)/2.0
        loginLabel.center.x = view.center.x
        loginLabel.textColor = .white
        loginLabel.font = UIFont.boldSystemFont(ofSize: 30)
        loginLabel.sizeToFit()
        
        //Line Below PasswordTextField
        lineBelowPasswordTextField.frame = CGRect(x: passwordTextField.frame.minX, y: passwordTextField.frame.maxY + 5.0, width: buttonWidth, height: 2.0)
        lineBelowPasswordTextField.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        
        //Footer Label
        footerLabel.frame = CGRect(x: passwordTextField.frame.minX, y: passwordTextField.frame.maxY + 10.0, width: buttonWidth, height: 20.0)
        footerLabel.center.y = lineBelowPasswordTextField.frame.maxY + (footerLabel.frame.height/2.0) + 10.0
        footerLabel.text = "Please Enter Your Password To Login"
        footerLabel.textColor = .white
        footerLabel.adjustsFontSizeToFitWidth = true
        
        
        view.addSubview(loginButton)
        view.addSubview(loginLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordLabel)
        view.addSubview(footerLabel)
        view.addSubview(incorrectPasswordFooterLabel)
        
        view.layer.addSublayer(lineBelowPasswordTextField)
        
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
        continueToNextScreen()
        return true
    }
    

    func continueToNextScreen() {
        //Check if email and password is correct
        
        lineBelowPasswordTextField.backgroundColor = passwordTextField.text?.characters.count == 0 ? UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor : UIColor.white.cgColor
        userPassword = passwordTextField.text?.characters.count == 0 ? "" : passwordTextField.text!
        
        
        let parameters: Parameters = [
            "useremail" : userEmail.lowercased(),
            "password" : userPassword
        ]
        print("Parameters for returning user: \(parameters)")
        //Communicate with server via Alamofire.
        //Method: POST
        Alamofire.request("http://mingplusyang.com/fitcatDB/login.php", method: .post, parameters: parameters).response{
            response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let userID = Int(utf8Text)!
                let userCanLogin = userID != 0
                if userCanLogin {
                    self.footerLabel.isHidden = true
                    self.incorrectPasswordFooterLabel.isHidden = true
                    
                    //let mainVC = catCardsViewController()
                    //self.present(mainVC, animated: true, completion: nil)
                    //let dest = self.storyboard?.instantiateViewController(withIdentifier: "createCatView")
                    //self.present(dest!, animated: true, completion: nil)
                    guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createCatView") as? CreateCatViewController
                        else {
                            print("Could not instantiate view controller with identifier of type SecondViewController")
                            return
                    }
                    self.present(vc, animated: true, completion: nil)
                    
                } else {
                    self.footerLabel.isHidden = true
                    self.incorrectPasswordFooterLabel.frame = self.footerLabel.frame
                    self.incorrectPasswordFooterLabel.text = "Your Password Is Incorrect"
                    self.incorrectPasswordFooterLabel.textColor = UIColor(red: 217.0/255.0, green: 73.0/255.0, blue: 55.0/255.0, alpha: 1.0)
                    self.incorrectPasswordFooterLabel.backgroundColor = .white
                    self.incorrectPasswordFooterLabel.adjustsFontSizeToFitWidth = true
                    self.passwordTextField.shake()
                }
            }
        }
    }
}
