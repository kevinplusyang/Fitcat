//
//  ViewController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/8/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit


class mainPageController: UIViewController {
    
    var currentCount:Int = 0
    var maxCount: Int = 360
    
    @IBOutlet var circularProgressView: KDCircularProgress!
    @IBOutlet var catImg: UIImageView!
    
    @IBOutlet weak var weightsView: UIView!
    @IBOutlet weak var feedingView: UIView!
    
    @IBOutlet weak var feedingsBtn: UIButton!
    @IBOutlet weak var weightsBtn: UIButton!
    @IBOutlet weak var logBtn: UIButton!
   
    @IBOutlet weak var measureIconR: UIImageView!
    @IBOutlet weak var measureIconG: UIImageView!
    @IBOutlet weak var feedingIconR: UIImageView!
    @IBOutlet weak var feedingIconG: UIImageView!
    
    @IBOutlet weak var weigtBtnLabel: UILabel!
    @IBOutlet weak var feedingsBtnLabel: UILabel!
    
    //segments control
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var todayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //circularProgressView.angle = 0
        
        
        //round cat image
        catImg.layer.borderWidth = 1
        catImg.layer.masksToBounds = false
        catImg.layer.borderColor = UIColor.white.cgColor
        catImg.layer.cornerRadius = catImg.frame.height/2
        catImg.clipsToBounds = true
        
        //progress bar
        circularProgressView.startAngle = 90
        circularProgressView.progressThickness = 0.15
        circularProgressView.trackThickness = 0.3
        circularProgressView.clockwise = true
        circularProgressView.gradientRotateSpeed = 2
        circularProgressView.roundedCorners = false
        
        //hide weightsView
        weightsView.isHidden = true
        
        //change segments' UI style
        segments.layer.borderColor = UIColor.gray.cgColor
               
        //hide red measureIcon and grey feedingicon
        measureIconR.isHidden = true
        feedingIconG.isHidden = true
        
        //hide monthView yearView
        monthView.isHidden = true
        yearView.isHidden = true
        
        //log button rounded corner
        logBtn.layer.cornerRadius = 5

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to calculate the new angle for the progress bar
    func newAngle() -> Int {
        return Int(360 * (currentCount / maxCount))
    }
    

    
    @IBAction func animateTapped(_ sender: UIButton) {
        if currentCount != maxCount {
            currentCount += 1
            print("currentCount \(currentCount)")
            let newAngleValue = newAngle()
            print("newAngleValue \(newAngleValue)")
            circularProgressView.animate(toAngle: Double(90), duration: 0.5, completion: nil)
        }
        
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        currentCount = 0
        circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
    }
    
    @IBAction func feedingsBtnTapped(_ sender: UIButton) {
        weightsView.isHidden = true
        feedingView.isHidden = false
        measureIconR.isHidden = true
        measureIconG.isHidden = false
        feedingIconG.isHidden = true
        feedingIconR.isHidden = false
        weigtBtnLabel.textColor = UIColor(red: 0.607843, green: 0.607843, blue: 0.607843, alpha: 1)
        feedingsBtnLabel.textColor = UIColor(red: 0.89411765, green: 0.34901961, blue: 0.25098039, alpha: 1)
    }
   
    @IBAction func weightsBtnTapped(_ sender: UIButton) {
        feedingView.isHidden = true
        weightsView.isHidden = false
        measureIconR.isHidden = false
        measureIconG.isHidden = true
        feedingsBtnLabel.textColor = UIColor(red: 0.607843, green: 0.607843, blue: 0.607843, alpha: 1)
        weigtBtnLabel.textColor = UIColor(red: 0.89411765, green: 0.34901961, blue: 0.25098039, alpha: 1)
        feedingIconG.isHidden = false
        feedingIconR.isHidden = true
        
    }

    @IBAction func segmentsChanged(_ sender: UISegmentedControl) {
        let index: Int = sender.selectedSegmentIndex
        let title: String = sender.titleForSegment(at: index)!
        print("segment clicked is \(title)")
        print("index clicked is \(index)")
        if (index == 0) {
            todayView.isHidden = false
            monthView.isHidden = true
            yearView.isHidden = true
        }else if (index == 1){
            todayView.isHidden = true
            monthView.isHidden = false
            yearView.isHidden = true
        }else{
            todayView.isHidden = true
            monthView.isHidden = true
            yearView.isHidden = false
            
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     segue.destinationViewController
     }
     */
    
}
