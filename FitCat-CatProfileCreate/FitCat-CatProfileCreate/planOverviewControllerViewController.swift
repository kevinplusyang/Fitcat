//
//  planOverviewControllerViewController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/6/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit

class planOverviewControllerViewController: UIViewController {
    
    //cat profile image
    
    @IBOutlet weak var catImg: UIImageView!
    
    //button outlet
    @IBOutlet weak var gotItBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //cat image
        catImg.layer.borderWidth = 1
        catImg.layer.masksToBounds = false
        catImg.layer.borderColor = UIColor.white.cgColor
        catImg.layer.cornerRadius = catImg.frame.height/2
        catImg.clipsToBounds = true
        
        //button UI editing
        gotItBtn.backgroundColor = UIColor.clear
        gotItBtn.layer.cornerRadius = 5
        gotItBtn.layer.borderWidth = 1
        gotItBtn.layer.borderColor = UIColor.white.cgColor
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
