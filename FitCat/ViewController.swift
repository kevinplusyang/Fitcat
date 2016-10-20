//
//  ViewController.swift
//  FitCat
//
//  Created by Kevin Yang on 10/19/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    var loginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                // Optional: Place the button in the center of your view.
        self.loginButton.center = self.view.center
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.loginButton.delegate = self
        self.view.addSubview(loginButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User logged in")
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User did logout")
    }

}

