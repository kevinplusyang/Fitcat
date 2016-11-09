//
//  createCat.swift
//  FitCat
//
//  Created by Kevin Yang on 11/3/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//


import UIKit
import Foundation
import Alamofire

class createCat: UIViewController {
    var selectedName: String = "Anonymous"
    var toPass: String = "Anonymous"
    var u_id = floginobj.f_id
    var result = 2;
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        print("resultis:\(u_id)")
        
        
        
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/navigationAfterLogin.php?user_id=\(u_id)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                self.result = Int(utf8Text)!
                
            }
        }
        
        
        if(result == 0){
            
            let dest = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
            self.present(dest!, animated: true, completion: nil)
            
            
        }
        
        if(result == 1){
            
            let dest = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
            self.present(dest!, animated: true, completion: nil)
            
            
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
    
    
    
    
}

