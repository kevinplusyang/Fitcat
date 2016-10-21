//
//  ViewController.swift
//  FitCat
//
//  Created by Kevin Yang on 10/19/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    class FBCred {
        var f_id : String = ""
        var f_name: String = ""
    }
    
    var loginButton = FBSDKLoginButton()
    var floginobj = FBCred()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                // Optional: Place the button in the center of your view.
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        print("Here")
        
        if (FBSDKAccessToken.current() != nil) {
            print("Loggined in")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User logged in")
//        floginobj.f_id = authData.uid.substringFromIndex(authData.uid.startIndex.advancedBy(9))
//        floginobj.f_name = authData.providerData["displayName"] as! String
//        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        
//        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//            // ...
//        }
        
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User did logout")
    }

}



