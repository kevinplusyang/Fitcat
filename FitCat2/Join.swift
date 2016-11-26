//
//  Join.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class JoinController: UIViewController, UITextFieldDelegate {
    
    
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
    @IBAction func submitResult(_ sender: UIButton) {
       
        
        
        
        print("Clikced Submit")
        print("User Name: \(username.text!)")
        print("Password: \(password.text!)")
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/join.php?username=\(username.text!)&password=\(password.text!)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            
            
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                if(utf8Text == "1"){
                    let dest = self.storyboard?.instantiateViewController(withIdentifier: "welcomePage")
                    self.present(dest!, animated: true, completion: nil)
                    
                }else{
                    let alert = UIAlertController(title: "Error", message:"User Name Already Exist", preferredStyle: .alert)
                    let closeAction = UIAlertAction(title:"Close", style: .cancel, handler: nil)
                    alert.addAction(closeAction)
                    self.present(alert, animated: true, completion:nil)
                }
                
            }else{
                let alert = UIAlertController(title: "Error", message:"Network Connection Error", preferredStyle: .alert)
                let closeAction = UIAlertAction(title:"Close", style: .cancel, handler: nil)
                alert.addAction(closeAction)
                self.present(alert, animated: true, completion:nil)
            }
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

