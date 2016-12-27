//
//  tipsForSuccessControllerViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

class tipsForSuccessControllerViewController: UIViewController {
    
    @IBOutlet weak var tip1: UITextView!
    @IBOutlet weak var tip2: UITextView!
    @IBOutlet weak var tip3: UITextView!
    @IBOutlet weak var tip4: UITextView!
    
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var circle3: UIView!
    @IBOutlet weak var circle4: UIView!
    
    @IBOutlet weak var subCircle1: UIView!
    @IBOutlet weak var subCircle2: UIView!
    @IBOutlet weak var subCircle3: UIView!
    @IBOutlet weak var subCircle4: UIView!
    
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    
    @IBOutlet weak var gotItBtn: UIButton!
    @IBOutlet weak var gotItBtn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tip2.isHidden = true
        tip3.isHidden = true
        tip4.isHidden = true
        circle2.isHidden = true
        circle3.isHidden = true
        circle4.isHidden = true
        line2.isHidden = true
        line3.isHidden = true
        
        circle1.layer.borderWidth = 1
        circle1.layer.masksToBounds = false
        circle1.layer.borderColor = UIColor.white.cgColor
        circle1.layer.cornerRadius = circle1.frame.height/2
        circle1.clipsToBounds = true
        
        subCircle1.layer.borderWidth = 1
        subCircle1.layer.masksToBounds = false
        subCircle1.layer.borderColor = UIColor.white.cgColor
        subCircle1.layer.cornerRadius = subCircle1.frame.height/2
        subCircle1.clipsToBounds = true
        
        subCircle2.isHidden = true
        subCircle3.isHidden = true
        subCircle4.isHidden = true
        
        gotItBtn.layer.cornerRadius = 5
        gotItBtn.layer.borderWidth = 1
        gotItBtn.layer.borderColor = UIColor.white.cgColor
        
        gotItBtn2.isHidden = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var count = 1
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if count == 1 {
            
            tip2.isHidden = false
            line2.isHidden = false
            circle2.isHidden = false
            
            circle2.layer.borderWidth = 1
            circle2.layer.masksToBounds = false
            circle2.layer.borderColor = UIColor.white.cgColor
            circle2.layer.cornerRadius = circle2.frame.height/2
            circle2.clipsToBounds = true
            
            subCircle2.layer.borderWidth = 1
            subCircle2.layer.masksToBounds = false
            subCircle2.layer.borderColor = UIColor.white.cgColor
            subCircle2.layer.cornerRadius = subCircle2.frame.height/2
            subCircle2.clipsToBounds = true
            
            tip1.textColor = UIColor(white: 1.0, alpha: 0.5)
            
            count += 1
        }
        else if count == 2{
            tip3.isHidden = false
            line3.isHidden = false
            circle3.isHidden = false
            
            circle3.layer.borderWidth = 1
            circle3.layer.masksToBounds = false
            circle3.layer.borderColor = UIColor.white.cgColor
            circle3.layer.cornerRadius = circle3.frame.height/2
            circle3.clipsToBounds = true
            
            subCircle2.isHidden = false
            subCircle3.layer.borderWidth = 1
            subCircle3.layer.masksToBounds = false
            subCircle3.layer.borderColor = UIColor.white.cgColor
            subCircle3.layer.cornerRadius = subCircle3.frame.height/2
            subCircle3.clipsToBounds = true
            
            tip2.textColor = UIColor(white: 1.0, alpha: 0.5)
            
            count += 1
            
        }else if count == 3{
            tip4.isHidden = false
            
            circle4.isHidden = false
            
            circle4.layer.borderWidth = 1
            circle4.layer.masksToBounds = false
            circle4.layer.borderColor = UIColor.white.cgColor
            circle4.layer.cornerRadius = circle4.frame.height/2
            circle4.clipsToBounds = true
            
            subCircle3.isHidden = false
            subCircle4.layer.borderWidth = 1
            subCircle4.layer.masksToBounds = false
            subCircle4.layer.borderColor = UIColor.white.cgColor
            subCircle4.layer.cornerRadius = subCircle4.frame.height/2
            subCircle4.clipsToBounds = true
            
            tip3.textColor = UIColor(white: 1.0, alpha: 0.5)
            
            //show the button which directs to the next page when clicked
            gotItBtn.isHidden = true
            gotItBtn2.isHidden = false
            gotItBtn2.layer.cornerRadius = 5
            gotItBtn2.layer.borderWidth = 1
            gotItBtn2.layer.borderColor = UIColor.white.cgColor
        }
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

