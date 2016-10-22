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
import Foundation
import Alamofire


class ViewController: UIViewController {
    
    class FBCred {
        var f_id : String = ""
        var f_name: String = ""
    }

    
//     let ref = FIRDatabase.database().reference()
 
 
//    var loginButton = FBSDKLoginButton()
    var floginobj = FBCred()
    

    override func viewDidLoad() {
        
//        Alamofire.request("https://httpbin.org/get").responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/jsontest.php").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }

        let xx = 14
        Alamofire.request("http://mingplusyang.com/fitcatDB/insert.php?id=\(xx)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
        
   
        
//        ref.child("newchild").setValue("babbaaaa")
//        
//        ref.observe(.childAdded, with: { (snapshot) in
//            print("This is what is in the database \(snapshot)")
//            
//        })
        
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        
                // Optional: Place the button in the center of your view.
       get()
//        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
//        loginButton.delegate = self
//        loginButton.center = self.view.center
//        self.view.addSubview(loginButton)
        print("Here")
        
//        if (FBSDKAccessToken.current() != nil) {
//            print("Loggined in")
//        }

    }
    
    
    
 
    
    func get(){
        
        
//        let url = URL(string: "http://www.mingplusyang.com/fitcatDB/get.php")
//        var request = URLRequest(url: url! as URL)
//        request.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: request as URLRequest){
//            
//        }
        
        
        
        
        print("Here3")

        if let url = URL(string: "http://www.mingplusyang.com/fitcatDB/get.php") {
            do {
                let contents = try String(contentsOf: url)
                print(contents)
                print("Here2")
            } catch {
                // contents could not be loaded
                 print("nothinghere")
            }
        } else {
            // the URL was bad!
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        print("User logged in")
////        floginobj.f_id = authData.uid.substringFromIndex(authData.uid.startIndex.advancedBy(9))
////        floginobj.f_name = authData.providerData["displayName"] as! String
////        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//        
//        
////        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
////            // ...
////        }
////        var credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
////
////
//        
//        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//            print(user?.displayName)
//        }
//
//        
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        print("User did logout")
//    }
//
}



