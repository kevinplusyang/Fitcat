//
//  TermsOfServiceViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/24/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire

class TermsOfServiceViewController: UIViewController{
    
    let userDefaults = UserDefaults.standard
    var userEmail = ""
    var userPassword = ""
    let gradient = CAGradientLayer()
    let termsOfServiceLabel = UILabel()
    let agreeButton = UIButton()
    let termsOfServiceTextView = UITextView()
    let termsOfService = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut urna rutrum lacus sollicitudin luctus et eu metus. Sed a nisi vehicula, mattis eros id, aliquam mauris. Vivamus fringilla augue sed molestie accumsan. Cras sed augue ut nibh semper porttitor. Sed nisl libero, condimentum nec euismod vel, vestibulum vitae sapien. Curabitur sit amet diam et nunc congue eleifend. Aenean dictum porta nisi, eu dictum nulla aliquet sit amet. Curabitur velit dui, convallis et sapien id, vestibulum ultricies ex. Vivamus ac sapien ultrices, sagittis sem eu, ultricies lacus. Ut semper urna et metus luctus tempus. Curabitur molestie pellentesque tempor. Fusce at leo tincidunt, tincidunt odio at, semper nibh. Sed sem lacus, ultricies eget mi in, lacinia hendrerit dolor. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Quisque id orci ut nisl rhoncus tincidunt. Mauris pulvinar mauris massa, eget tristique eros placerat non. Ut arcu dui, congue eget ante id, tempor ullamcorper magna. Pellentesque accumsan congue nulla, mollis interdum magna molestie venenatis. Duis id justo elementum sem ornare tempor. Praesent at euismod velit. Quisque eu odio egestas, ornare purus ac, rhoncus erat. Donec ligula magna, finibus a fermentum ac, finibus at ante. Pellentesque viverra lectus at fermentum viverra. Morbi aliquet rutrum sapien, nec vehicula nulla posuere sit amet. Maecenas blandit nisi nisi, vitae eleifend nibh commodo et. Phasellus eu aliquam ligula. Donec consectetur id purus et vestibulum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus neque sem, iaculis in nulla non."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradient()
        self.navigationItem.title = ""
        //Button set up
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        agreeButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        agreeButton.center.x = view.center.x
        agreeButton.layer.borderWidth = 2.0
        agreeButton.layer.borderColor = UIColor.white.cgColor
        agreeButton.layer.cornerRadius = 7
        agreeButton.setTitle("Agree and Continue", for: .normal)
        agreeButton.setTitleColor(.lightGray, for: .highlighted)
        agreeButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        
        //emailTextField set up
        let startOfTextView = view.bounds.height * 0.20
        let endOfTextView = agreeButton.frame.minY - 35.0
        
        termsOfServiceTextView.frame =  CGRect(x: CGFloat(0), y: startOfTextView, width: buttonWidth, height: endOfTextView - startOfTextView)
        termsOfServiceTextView.center.x = view.center.x
        termsOfServiceTextView.textColor = .white
        termsOfServiceTextView.backgroundColor = .clear
        termsOfServiceTextView.text = termsOfService
        termsOfServiceTextView.allowsEditingTextAttributes = false
        termsOfServiceTextView.isEditable = false
        termsOfServiceTextView.font = UIFont.systemFont(ofSize: 14)

     
        
        
        //welcome label
        termsOfServiceLabel.text = "Terms of Service"
        termsOfServiceLabel.frame = agreeButton.frame
       termsOfServiceLabel.center.y = view.bounds.height * 0.15
        termsOfServiceLabel.center.x = view.center.x
        termsOfServiceLabel.textColor = .white
        termsOfServiceLabel.font = UIFont.boldSystemFont(ofSize: 30)
        termsOfServiceLabel.sizeToFit()

        view.addSubview(agreeButton)
        view.addSubview(termsOfServiceLabel)
        view.addSubview(termsOfServiceTextView)
        
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
        //use userEmail and userPassword to create a new user and then continue to prefVC
        //Prepare the inputed text in fields and store them in variable parameters
        
        //MARK: Get Actual Username From Client
        let parameters: Parameters = [
            "useremail" : userEmail.lowercased(),
            "password" : userPassword,
            "username" : "default_username"
        ]
        
        print("Parameters for join.php: \(parameters)")
        //Communicate with server via Alamofire
        //Using POST method.
        //Only when the insertion success, the server will response status '1'
        Alamofire.request("http://mingplusyang.com/fitcatDB/join.php", method: .post, parameters: parameters).response{
            response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                let userID = Int(utf8Text) != nil ? Int(utf8Text)! : 0
                print("userID is: \(userID)")
                self.userDefaults.set(userID, forKey: "userID")
            }
        }
        let prefVC = PreferencesViewController()
        navigationController?.pushViewController(prefVC, animated: true)
    }
}
