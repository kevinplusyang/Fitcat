//
//  InitialViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire
import Google
import GoogleSignIn

class InitialViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    let userDefaults = UserDefaults.standard
    var userEmail = ""
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
        
        
        
        
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let signInButton = GIDSignInButton(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100)) )
        signInButton.center = view.center
        view.addSubview(signInButton)

        
        
        setUpGradient()
        self.navigationItem.title = ""
        
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
        emailTextField.frame =  CGRect(x: CGFloat(0), y: loginButton.frame.minY - view.frame.midY, width: buttonWidth, height: CGFloat(buttonHeight) - 10.0)
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
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        welcomeLabel.sizeToFit()
        
        //white line below
        lineBelowEmailTextField.frame = CGRect(x: emailTextField.frame.minX, y: emailTextField.frame.maxY + 5.0, width: buttonWidth, height: 2.0)
        lineBelowEmailTextField.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor
        
        
        //footer label
        footerLabel.frame = CGRect(x: emailTextField.frame.minX, y: emailTextField.frame.maxY + 10.0, width: buttonWidth, height: 20.0)
        footerLabel.center.y = lineBelowEmailTextField.frame.maxY + (footerLabel.frame.height/2.0) + 10.0
        footerLabel.text = "Please Enter Your Email To Continue"
        footerLabel.textColor = .white
        footerLabel.adjustsFontSizeToFitWidth = true
        
   
//        view.addSubview(loginButton)
        view.addSubview(welcomeLabel)
//        view.addSubview(emailTextField)
//        view.addSubview(emailLabel)
//        view.layer.addSublayer(lineBelowEmailTextField)
//        view.addSubview(footerLabel)
//        view.addSubview(incorrectEmailFooterLabel)

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
        continueToNextScreen()
        return true
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print("Is \(testStr) a valid email? \(emailTest.evaluate(with: testStr))")
        return emailTest.evaluate(with: testStr)
    }
    
    func continueToNextScreen() {
        lineBelowEmailTextField.backgroundColor = emailTextField.text?.characters.count == 0 ? UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6).cgColor : UIColor.white.cgColor
        isEmailValid = emailTextField.text?.characters.count == 0 ? false : isValidEmail(testStr: emailTextField.text!)
        userEmail = emailTextField.text?.characters.count == 0 ? "" : emailTextField.text!
    
        let parameters: Parameters = [
            "email" : userEmail
        ]
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/checkEmail.php", method: .post, parameters: parameters).response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let isInDatabase = Int(utf8Text)! == 1
                if isInDatabase && self.isEmailValid {
                    self.footerLabel.isHidden = true
                     self.incorrectEmailFooterLabel.isHidden = true
                     let returningUserVC = ReturningUserViewController()
                    returningUserVC.userEmail = self.userEmail
                     self.navigationController?.pushViewController(returningUserVC, animated: true)
                } else if !isInDatabase && self.isEmailValid {
                    let signUpVC = SignUpViewController()
                    signUpVC.userEmail = self.userEmail
                    self.navigationController?.pushViewController(signUpVC, animated: true)
                    
                } else {
                    //display invalid email error
                    self.footerLabel.isHidden = true
                    self.incorrectEmailFooterLabel.frame = self.footerLabel.frame
                    self.incorrectEmailFooterLabel.text = "Oops. Please enter a valid email address."
                    self.incorrectEmailFooterLabel.textColor = UIColor(red: 217.0/255.0, green: 73.0/255.0, blue: 55.0/255.0, alpha: 1.0)
                    self.incorrectEmailFooterLabel.backgroundColor = .white
                    self.incorrectEmailFooterLabel.adjustsFontSizeToFitWidth = true
                    self.emailTextField.shake()

                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(user.profile.email)
        print(user.profile.givenName)
        print(user.profile.imageURL(withDimension: 400))
        print(user.userID)
        print(user.profile.familyName)
        
        
        
        let parameters: Parameters = [
            "email" : user.profile.email,
            "givenName" : user.profile.givenName,
            "familyName" : user.profile.familyName,
            "googleId" : user.userID,
            "googleImage" : user.profile.imageURL(withDimension: 400)
        ]
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/checkGoogleAccount.php", method: .post, parameters: parameters).response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let isInDatabase = Int(utf8Text)
                if isInDatabase == 0 {
//                    self.footerLabel.isHidden = true
//                    self.incorrectEmailFooterLabel.isHidden = true
//                    let returningUserVC = ReturningUserViewController()
//                    returningUserVC.userEmail = self.userEmail
//                    self.navigationController?.pushViewController(returningUserVC, animated: true)
                    
                    let tosVC = TermsOfServiceViewController()
                    tosVC.userEmail = user.profile.email
                    tosVC.userGivenName = user.profile.givenName
                    tosVC.userFamilyName = user.profile.familyName
                    tosVC.userGoogleID = user.userID
                    tosVC.userGoogleImageID = String(describing: user.profile.imageURL(withDimension: 400)!)
                    self.navigationController?.pushViewController(tosVC, animated: true)
                    
                } else {
                    self.userDefaults.set(isInDatabase, forKey: "userID")
                    self.userDefaults.set(isInDatabase, forKey: "userGivenName")
                    self.userDefaults.set(isInDatabase, forKey: "userFamilyName")
                    self.userDefaults.set(isInDatabase, forKey: "userGoogleID")
                    self.userDefaults.set(isInDatabase, forKey: "userGoogleImageID")
                    guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createCatView") as? catDetailsController
                        else {
                            print("Could not instantiate view controller with identifier of type SecondViewController")
                            return
                    }
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }

    }
    
    func googleLoginUser(email : String, givenName : String, familyName : String, userId : String, userImage : String) {
        
    }

}
