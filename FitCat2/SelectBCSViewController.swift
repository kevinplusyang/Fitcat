//
//  selectBcsController.swift
//  FitCat-CatProfileCreate
//
//  Created by KY on 11/2/16.
//  Copyright © 2016 KYKY. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class selectBcsController: UIViewController {
    
    @IBOutlet weak var catNameLable: UILabel!
    @IBOutlet weak var bcs5: UIButton!
    @IBOutlet weak var bcs7: UIButton!
    @IBOutlet weak var bcs9: UIButton!
    @IBOutlet weak var individualBtn: UIButton!
    @IBOutlet weak var superimposedBtn: UIButton!
    @IBOutlet weak var continueBtnOL: UIButton!
    @IBOutlet weak var BCStext: UITextView!
    @IBOutlet weak var BCSLabel: UILabel!
    @IBOutlet weak var individualView: UIView!
    @IBOutlet weak var superimposedView: UIView!
    
    var newCat: CreateCatModel!
    
    override func viewDidLoad() {
        backgroundGradient()
        title = "Select BCS"
        
        bcs7.layer.borderWidth = 2
        bcs7.layer.borderColor = UIColor.white.cgColor
        bcs7.layer.cornerRadius = 5
        bcs7.backgroundColor = UIColor(red:255/255.0,green:255/255.0,blue:255/255.0,alpha: 0.5)
        BCSLabel.text! = "BCS 7"
        
        bcs5.layer.cornerRadius = 5
        bcs5.backgroundColor = UIColor(red:255/255.0,green:255/255.0,blue:255/255.0,alpha: 0.5)
        
        bcs9.layer.cornerRadius = 5
        bcs9.backgroundColor = UIColor(red:255/255.0,green:255/255.0,blue:255/255.0,alpha: 0.5)
        
        continueBtnOL.backgroundColor = UIColor.clear
        continueBtnOL.layer.cornerRadius = 5
        continueBtnOL.layer.borderWidth = 1
        continueBtnOL.layer.borderColor = UIColor.white.cgColor
        
        superimposedView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        superimposedView.isHidden = true
        superimposedView.layer.cornerRadius = 5
        superimposedBtn.layer.cornerRadius = 8
        
        
        individualView.backgroundColor = UIColor.clear
        individualBtn.layer.cornerRadius = 8
        individualBtn.layer.borderWidth
            = 1
        individualBtn.layer.borderColor = UIColor.white.cgColor
        
        BCStext.backgroundColor = UIColor.clear
        BCStext.text! = "Spine, ribs, and pelvic bones not easily felt with moderate fat layer covering them, waist diminished, abdomen rounded with moderate abdominal fat pad."
        BCStext.textColor = UIColor.white
        catNameLable.text = newCat.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //segue.destination
        let destVC = segue.destination as! tipsForSuccessControllerViewController
        destVC.newCat = newCat
    }
    
    
    //background gradient color
    func backgroundGradient(){
        let bottomColor = UIColor(red:227/255.0,green:70/255.0,blue:51/255.0,alpha: 1)
        let topColor = UIColor(red:228/255.0,green:100/255.0,blue:73/255.0,alpha: 1)
        let gradientColors:[CGColor] = [topColor.cgColor, bottomColor.cgColor,topColor.cgColor, bottomColor.cgColor]
        let gradientLocations:[Float] = [0.0,1.0]
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer,at: 0)
    }
    
    
    @IBAction func individualBtnTapped(_ sender: UIButton) {
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        superimposedBtn.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        superimposedBtn.titleLabel?.tintColor = UIColor(white: 1.0, alpha: 0.5)
        individualView.isHidden = false
        superimposedView.isHidden = true
    }
    
    @IBAction func superimposedBtnTapped(_ sender: UIButton) {
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.white.cgColor
        sender.titleLabel?.tintColor = UIColor(white: 1.0, alpha: 1.0)
        individualBtn.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        individualBtn.titleLabel?.tintColor = UIColor(white: 1.0, alpha: 0.5)
        superimposedView.isHidden = false
        individualView.isHidden = true
    }
    
    
    //BCS5 btn
    @IBAction func bcs5tapped(_ sender: UIButton) {
        
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.white.cgColor
        
        bcs7.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        bcs9.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        BCSLabel.text! = "BCS 5"
        BCStext.text! = "Spine, ribs, and pelvic bones not visible but easily felt, evenly distributed muscle mass, minimal abdominal fat with abdominal tuck."
        print("selected5")
        newCat.initial_bcs = 6
    }
    
    //BCS7 btn
    @IBAction func bcs7tapped(_ sender: UIButton) {
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.white.cgColor
        bcs5.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        bcs9.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        BCSLabel.text! = "BCS 7"
        BCStext.text! = "Spine, ribs, and pelvic bones not easily felt with moderate fat layer covering them, waist diminished, abdomen rounded with moderate abdominal fat pad."
        print("selected7")
        newCat.initial_bcs = 7
    }
    
    //BCS9 btn
    @IBAction func bcs9tapped(_ sender: UIButton) {
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.white.cgColor
        bcs5.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        bcs7.layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        BCSLabel.text! = "BCS 9"
        BCStext.text! = "Spine, ribs, and pelvic bones cannot be felt, excessive abdominal fat, waist absent."
        print("selected9")
        newCat.initial_bcs = 9
    }
    
    //continue button
    @IBAction func continueBtnClicked(_ sender: UIButton) {
        //Prepare the information to be transmitted
        let parameters: Parameters = [
            "a1" : newCat.user_id,
            "a2" : newCat.name,
            "a3" : newCat.birthday,
            "a4" : newCat.breed_id,
            "a5" : newCat.initial_weight,
            "a6" : newCat.neutered,
            "a7" : newCat.gender,
            "a8" : newCat.initial_bcs,
            "a9" : newCat.image_id
        ]
        
        print(parameters)
        
        //Communicate with server via Alamofire
        //Using POST method.
        //After successfully create a cat profile on server, Server will response the cat id which is a unique 
        //number to mark the cat.
        Alamofire.request("http://mingplusyang.com/fitcatDB/createCat.php", method: .post, parameters: parameters).response{
            response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                self.newCat.cat_id = Int(utf8Text) != nil ? Int(utf8Text)! : 999
                print("CatID:\(self.newCat.cat_id)")
            }
        }
        
        
        
    }
}
