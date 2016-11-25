//
//  secondViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//


import UIKit
import Foundation
import Alamofire

class SecondViewController: UIViewController {
    var selectedName: String = "Anonymous"
    var toPass: String = "Anonymous"
    var u_id = floginobj.f_id
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        print("resultis:\(u_id)")
        
        
        var result = 9;
        
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/navigationAfterLogin.php?user_id=\(u_id)").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                result = Int(utf8Text)!
                
                if(result == 0){
                    let dest = self.storyboard?.instantiateViewController(withIdentifier: "createCatView")
                    self.present(dest!, animated: true, completion: nil)
                }
                
                if(result == 1){
                    //                    let dest = self.storyboard?.instantiateViewController(withIdentifier: "catTable")
                    //                    self.present(dest!, animated: true, completion: nil)
                    
                    //                    var storyboard = UIStoryboard(name: "TableViewCont", bundle: nil)
                    let tvc = (self.storyboard?.instantiateViewController(withIdentifier: "catTable") as! UITableViewController)
                    self.present(tvc, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
            }
        }
        
        print("RRR: \(result)")
        
        
        
        //        if(result == 0){
        //
        //            print("CreateCatview")
        //
        //            let dest = self.storyboard?.instantiateViewController(withIdentifier: "createCatView")
        //            self.present(dest!, animated: true, completion: nil)
        //
        //        }
        //        print("R1")
        //
        //        if(result == 1){
        //
        //            let dest = self.storyboard?.instantiateViewController(withIdentifier: "catTable")
        //            self.present(dest!, animated: true, completion: nil)
        //
        //
        //        }
        //        print("R2")
        
        
        
        
        
        
        
        
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

