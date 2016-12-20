//
//  newCatCardsCollectionViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/28/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos

private let reuseIdentifier = "cardCell"

class newCatCardsCollectionViewController: UICollectionViewController {
    
    //temp data placeholder
    let data:[String] = ["cat1","cat2","cat3"]
    var selectedData:String = ""
    var catID:[Int] = []
    var catName:[String] = []
    var calTotal:[Int] = []
    var calCurrent:[Int] = []
    var foodTotal:[Int] = []
    var foodCurrent:[Int] = []
    var calProgress:[Float] = []
    var foodProgress:[Float] = []
    var alertInformation:[String] = []
    var img:[UIImage] = []
    var img2:[UIImage] = []
    var imgURL:[String] = []
    
    func addPhoto(x: URL) {
        
        let assetUrl = x
        let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assetUrl], options: nil)
        
        if let photo = fetchResult.firstObject {
            // retrieve the image for the first result
            PHImageManager.default().requestImage(for: photo, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: nil) {
            image, info in
            self.img.append(image!)
                self.img.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
            //here is the image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        layoutCells()
        self.collectionView!.bounces = true
        self.collectionView!.isScrollEnabled = true
        
        Alamofire.request("http://www.mingplusyang.com/fitcatDB/getCat.php?a1=\(floginobj.f_id)").responseJSON { response in
            print("alo")
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                let count = json["count"].intValue
                print("JJSON:\(count)")
                var i = 0
                while i < count {
                    self.catName.append(json["catName"][i]["id"].stringValue)
                    i = i + 1
                }
                print("ssss:\(count)")
                print("ssss:\(self.catName)")
                
                i = 0
                while i < count {
                    self.calCurrent.append(json["calCurrent"][i]["cal"].intValue)
                    i = i + 1
                }
                i = 0
                
//                var assetUrl = URL(string: "assets-library://asset/asset.JPG?id=6484AD65-8FB1-405B-9B8A-BFE7E17756D8&ext=JPG")!
//                var fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assetUrl], options: nil)
//                var photo = fetchResult.firstObject
                
                while i < count {
//                    self.imgURL.append(json["imgID"][i]["id"].stringValue)
                    self.addPhoto(x: NSURL(string: json["imgID"][i]["id"].stringValue) as! URL)
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.catID.append(json["catID"][i]["id"].intValue)
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.calTotal.append(json["calTotal"][i]["cal"].intValue)
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.foodTotal.append(json["foodTotal"][i]["cal"].intValue)
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.foodCurrent.append(json["foodCurrent"][i]["cal"].intValue)
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.calProgress.append(Float(json["calCurrent"][i]["cal"].intValue) / Float(json["calTotal"][i]["cal"].intValue))
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.foodProgress.append(Float(json["foodCurrent"][i]["cal"].intValue) / Float(json["foodTotal"][i]["cal"].intValue))
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    
                    if(json["foodCurrent"][i]["cal"].intValue - json["foodTotal"][i]["cal"].intValue >= 0){
                        
                        self.alertInformation.append("Fed too Much")
                        
                    } else {
                        self.alertInformation.append("Fed in Normal Range")
                    }
                    
                    i = i + 1
                }
                
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        //layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 25.0
        //layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width)/2, height: ((UIScreen.main.bounds.size.width - 80)/2))
        layout.itemSize = CGSize(width:view.layer.bounds.size.width-30 ,height: 230)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 60)
        collectionView!.collectionViewLayout = layout
        print("called")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected:qw\(indexPath.row)")
        
        let selectedCatId = catID[indexPath.row]
        print("Selected:ID\(selectedCatId)")
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getCurrentCat.php?catId=\(selectedCatId)").responseJSON { response in
            
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                currentCatObj.cat_id = json["catId"].intValue  //Useful index
                currentCatObj.cat_name = json["catName"].stringValue //Display Useful
                currentCatObj.calories_total = json["calories_total"].doubleValue //Display Useful
                currentCatObj.calories_today = json["calories_today"].doubleValue  //Display Useful
                currentCatObj.food_total = json["food_total"].doubleValue //Display Useful
                currentCatObj.food_today = json["food_today"].doubleValue  //Display Useful
                currentCatObj.goal_weight = json["goal_weight"].floatValue //Display Useful
                currentCatObj.current_weight = json["current_weight"].floatValue  //Display Useful
                currentCatObj.current_bcs = json["current_bcs"].intValue //Display Useful
                currentCatObj.goal_bcs = json["goal_bcs"].intValue  //Goal BCS, typically is 5
                currentCatObj.weight_lose = json["weight_lose"].doubleValue
                currentCatObj.initial_weight = json["initial_weight"].floatValue
                currentCatObj.image_ID = json["img_ID"].stringValue
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "mainPage")
                self.present(dest!, animated: true, completion: nil)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return catName.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        cell.layer.cornerRadius = 5.0
        
        let label = cell.viewWithTag(1) as! UILabel
        let label2 = cell.viewWithTag(2) as! UILabel
        let label3 = cell.viewWithTag(3) as! UILabel
        let label4 = cell.viewWithTag(4) as! UILabel
        let label5 = cell.viewWithTag(5) as! UILabel
        let label8 = cell.viewWithTag(8) as! UILabel

        label.text = catName[indexPath.row]
        label2.text = String(calCurrent[indexPath.row])
        label3.text = String(calTotal[indexPath.row])
        label4.text = String(foodCurrent[indexPath.row])
        label5.text = String(foodTotal[indexPath.row])
        label8.text = alertInformation[indexPath.row]
        
        let calProgressBar = cell.viewWithTag(6) as! UIProgressView
        calProgressBar.progress = 1 - calProgress[indexPath.row]
        
        let foodProgressBar = cell.viewWithTag(7) as! UIProgressView
        foodProgressBar.progress = 1 - foodProgress[indexPath.row]

        let imgView = cell.viewWithTag(10) as! UIImageView
        
        img2.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
        img2.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
        img2.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
        img2.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
        img2.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
        img2.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
        img2.append(#imageLiteral(resourceName: "catImagePlaceHolder"))
        
        
        print("jJJJJJJJJ:\(img.count)")
        imgView.image = img2[indexPath.row]
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cardheader", for: indexPath)
        //headerView.frame.size.height = 50
        //headerReferenceSize =  100
        
        return headerView
    }
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

