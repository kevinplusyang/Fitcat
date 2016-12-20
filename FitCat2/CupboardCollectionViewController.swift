//
//  cupboardCollectionViewController.swift
//  FitCat
//
//  Created by KY on 11/20/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//private let reuseIdentifier = "Cell"

class cupboardCollectionViewController: UICollectionViewController {
    
    //temp data placeholder
    var foodLibrary:[String] = ["Beyond Grain Free Ocean Whitefish and Egg Recipe Natural Dry Cat Food","Beyond Grain Free White Meat Chicken and Egg Recipe Natural Dry Cat Food","EVO 95 Chicken and Turkey Recipe in Gravy Canned Cat Food","Beyond Superfood Blend Barley Egg and Cranberry Recipe Dry Cat Food","Beyond Superfood Blend Herring Egg Sweet Potato Recipe Dry Cat Food","Beyond White Meat Chicken While Oat Meal Recipe Dry Cat Food","EVO 95 Duck Recipe in Gravy Canned Cat Food"]
    var data:[String] = []
    var imageUsed:[UIImage] = []
    var foodID:[Int] = []
    var images = [UIImage(named:"Beyond Grain Free Ocean Whitefish and Egg Recipe Natural Dry Cat Food"),UIImage(named:"Beyond Grain Free White Meat Chicken and Egg Recipe Natural Dry Cat Food"),UIImage(named:"EVO 95 Chicken and Turkey Recipe in Gravy Canned Cat Food"),UIImage(named:"Beyond Superfood Blend Barley Egg and Cranberry Recipe Dry Cat Food"),UIImage(named:"Beyond Superfood Blend Herring Egg Sweet Potato Recipe Dry Cat Food"),UIImage(named:"Beyond White Meat Chicken While Oat Meal Recipe Dry Cat Food"),UIImage(named:"EVO 95 Duck Recipe in Gravy Canned Cat Food")]
    
    var selectedData:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Do any additional setup after loading the view.
        //gradient color
        let bottomColor = UIColor(red:84/255.0,green:187/255.0,blue:117/255.0,alpha: 1)
        let topColor = UIColor(red:15/255.0,green:118/255.0,blue:128/255.0,alpha: 1)
        let gradientColors:[CGColor] = [topColor.cgColor, bottomColor.cgColor,topColor.cgColor, bottomColor.cgColor]
        let gradientLocations:[Float] = [0.0,0.4,0.8,1.0]
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer,at: 0)
        
        layoutCells()
        Alamofire.request("http://www.mingplusyang.com/fitcatDB/getFavoriteStatus.php?a1=\(floginobj.f_id)").responseJSON { response in
            print("alo")
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                
                let count = json["count"].intValue
                print("JJSON:\(count)")
                var i = 0
                while i < count {
                    self.data.append(self.foodLibrary[json["foods"][i]["id"].intValue])
                    self.imageUsed.append(self.images[json["foods"][i]["id"].intValue]!)
                    
                    self.foodID.append(json["foods"][i]["id"].intValue)

                    i = i + 1
                }
                
                print("ssss:\(self.data)")
                self.collectionView?.reloadData()
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 40, bottom: 10, right: 40)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 70.0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 120)/2, height: ((UIScreen.main.bounds.size.width - 120)/2))
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: 80)
        collectionView!.collectionViewLayout = layout
        print("called")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Configure the cell
        print("called \(indexPath.row)")
        cell.layer.cornerRadius = 5.0
        let label = cell.viewWithTag(1) as! UILabel
        label.text = data[indexPath.row]
        let imgView = cell.viewWithTag(2) as! UIImageView
        imgView.image = imageUsed[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        //headerView.frame.size.height = 50
        //headerReferenceSize =  100
        
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected:qw\(indexPath.row)")
        
        let selectedCatId = foodID[indexPath.row]
        print("Selected:ID\(selectedCatId)")
        
        let requestFoodID = selectedCatId + 1;
        
        Alamofire.request("http://mingplusyang.com/fitcatDB/getFoodById.php?a1=\(requestFoodID)").responseJSON { response in
            
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                
                foodSelection.foodID = requestFoodID
                foodSelection.foodName = json["foodName"].stringValue
                foodSelection.cal = json["cal"].floatValue
                foodSelection.ifWet = json["ifWet"].intValue
                foodSelection.standardCan = json["standardCan"].floatValue
                
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "cupBoardView")
                self.present(dest!, animated: true, completion: nil)
                
            }
        }
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
