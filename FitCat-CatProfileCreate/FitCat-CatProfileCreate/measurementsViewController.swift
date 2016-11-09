//
//  measurementsViewController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/3/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit

class measurementsViewController: UIViewController {
    
    @IBOutlet weak var generatePlanBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        generatePlanBtn.backgroundColor = UIColor.clear
        generatePlanBtn.layer.cornerRadius = 5
        generatePlanBtn.layer.borderWidth = 1
        generatePlanBtn.layer.borderColor = UIColor.white.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
