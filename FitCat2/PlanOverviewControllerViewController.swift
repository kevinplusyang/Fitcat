//
//  planOverviewControllerViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos

class planOverviewControllerViewController: UIViewController {
    
    //cat profile image
    
    @IBOutlet weak var catImg: UIImageView!
    
    //button outlet
    //    @IBOutlet weak var gotItBtn: UIButton!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var weightLoss: UILabel!
    @IBOutlet weak var weightToLoss: UILabel!
    @IBOutlet weak var weightToLossPerMonth: UILabel!
    @IBOutlet weak var caloriesPerDay: UILabel!
    @IBOutlet weak var volumePerDay: UILabel!
    @IBOutlet weak var endDateBig: UILabel!
    var cat: CreateCatModel!
    
    @IBAction func gotItButton(_ sender: UIButton) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "mainPage") as! mainPageController
        dest.currentCat = cat
        self.present(dest, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //cat image
        catImg.layer.borderWidth = 1
        catImg.layer.masksToBounds = false
        catImg.layer.borderColor = UIColor.white.cgColor
        catImg.layer.cornerRadius = catImg.frame.height/2
        catImg.clipsToBounds = true
        let assetUrl = URL(string: cat.image_id)!
        
        // retrieve the list of matching results for your asset url
        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assetUrl], options: nil)
        if let photo = fetchResult.firstObject {
            // retrieve the image for the first result
            PHImageManager.default().requestImage(for: photo, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: nil) {
                image, info in
                self.catImg.image = image //here is the image
            }
        }
        print("Cat Start Date: \(self.cat.cat_plan?.start_date)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        self.startDate.text = dateFormatter.string(from: (self.cat.cat_plan?.start_date)!)
        self.endDate.text = dateFormatter.string(from: (self.cat.cat_plan?.end_date)!)
        self.weightLoss.text = "\((self.cat.cat_plan?.weight_lose)!.kilogramsToPounds().trim2Decimals())lb 5BCS"
        self.weightToLoss.text = "\((self.cat.cat_plan?.weight_lose)!.kilogramsToPounds().trim2Decimals()) lbs"
        self.weightToLossPerMonth.text = "\((self.cat.cat_plan?.weight_lose_per_month)!.kilogramsToPounds().trim2Decimals()) lbs"
        self.caloriesPerDay.text = "\((self.cat.cat_plan?.calories_to_lose_per_day)!.kilogramsToPounds().trim2Decimals()) Cal"
        self.volumePerDay.text = "\((self.cat.cat_plan?.food_volume_required)!) OZ"
        self.endDateBig.text = dateFormatter.string(from: (self.cat.cat_plan?.end_date)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

