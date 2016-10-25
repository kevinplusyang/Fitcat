//
//  login.swift
//  FitCat
//
//  Created by Kevin Yang on 10/22/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class loginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        password.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
        
        
    }
    
    var result = 0
    
    @IBAction func submit(_ sender: UIButton) {
        print("Clikced Submit")
        print("User Name: \(username.text!)")
        print("Password: \(password.text!)")
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/login.php?username=\(username.text!)&password=\(password.text!)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                self.result = Int(utf8Text)!
                
            }
        }
        
        
        if(result != 0){
            print("Auth Successed with ID: \(result)")
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//            self.navigationController?.pushViewController(secondViewController, animated: true)
            
            
            let viewControllerB = SecondViewController()
            viewControllerB.selectedName = "Taylor Swift"
            navigationController?.pushViewController(viewControllerB, animated: true)
            
            self.performSegue(withIdentifier: "SecondViewController", sender: self)
            
            
        } else {
            print("Auth Wrong!")
        }
        
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}



