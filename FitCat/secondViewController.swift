//
//  secondViewController.swift
//  FitCat
//
//  Created by Kevin Yang on 10/22/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
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
        // Do any additional setup after loading the view, typically from a nib.
        
        let myCustomViewController: loginController = loginController(nibName: nil, bundle: nil)
        let getThatValue = myCustomViewController.result
        
    
        print("resultis:\(u_id)")
        
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

