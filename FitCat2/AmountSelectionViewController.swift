//
//  amountSelectionViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/28/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire

class amountSelectionViewController: UIViewController {
    
    //FIREBASE: Food Selection
    
    //@IBOutlet weak var addToBowlBtn: UIButton!
    @IBOutlet weak var FeedBtn: UIButton!
    @IBOutlet weak var wetDrylabel: UILabel!
    @IBOutlet weak var cupLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var calDataLabel: UILabel!
    @IBOutlet weak var cupOrCanLabel: UILabel!
    @IBOutlet weak var unitDataLabel: UILabel!
    @IBOutlet weak var cupOrCanLabel2: UILabel!
    @IBOutlet weak var calProgressBar: UIProgressView!
    @IBOutlet weak var foodProgressBar: UIProgressView!
    @IBAction func feedAction(_ sender: UIButton) {
        print("clicked")
        print("OO:\(caloriesLabel.text)")
        var calTemp = caloriesLabel.text
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        calTemp = calTemp?.substring(to: (calTemp?.index(before:(calTemp?.endIndex)!))!)
        
        var volumeTemp = volumeLabel.text
        volumeTemp = volumeTemp?.substring(to: (volumeTemp?.index(before:(volumeTemp?.endIndex)!))!)
        volumeTemp = volumeTemp?.substring(to: (volumeTemp?.index(before:(volumeTemp?.endIndex)!))!)
        volumeTemp = volumeTemp?.substring(to: (volumeTemp?.index(before:(volumeTemp?.endIndex)!))!)
        
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        amountView.layer.cornerRadius = 8
        wetDrylabel.layer.cornerRadius = 10
        //addToBowlBtn.layer.cornerRadius = 5
        FeedBtn.layer.cornerRadius = 5
    
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

