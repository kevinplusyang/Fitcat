//
//  ViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
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
        super.viewDidLoad()
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
}


