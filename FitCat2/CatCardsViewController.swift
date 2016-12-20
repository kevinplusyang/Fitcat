//
//  catCardsViewController.swift
//  FitCat
//
//  Created by KY on 11/10/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import UIKit

class catCardsViewController: UIViewController {
    
    @IBOutlet weak var cardBg: UIView!
    @IBOutlet weak var catImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //card rounded corner
        cardBg.layer.cornerRadius = 5
        
        //cat img circle
        catImg.layer.borderWidth = 1
        catImg.layer.masksToBounds = false
        catImg.layer.borderColor = UIColor.white.cgColor
        catImg.layer.cornerRadius = catImg.frame.height/2
        catImg.clipsToBounds = true
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
