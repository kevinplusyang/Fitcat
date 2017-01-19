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
import RealmSwift

private let reuseIdentifier = "cardCell"

class newCatCardsCollectionViewController: UICollectionViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    let userDefaults = UserDefaults.standard
    
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
    var userCats: Results<CreateCatModel>!
    var catPlans: Results<PlanModel>!
    
    var userID = ""
    
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
        // Uncomment the following line to preserve selection between presentation
        collectionView?.emptyDataSetSource = self
        collectionView?.emptyDataSetDelegate = self
        let realm = try! Realm()
        userCats = realm.objects(CreateCatModel.self)
        
        userID = userDefaults.string(forKey: "userID")!
        
        layoutCells()
        self.collectionView!.bounces = true
        self.collectionView!.isScrollEnabled = true
        
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
        print("Selected:\(indexPath.row)")
        
        let selectedCat = userCats[indexPath.row]
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "mainPage") as! mainPageController
        dest.currentCat = selectedCat
        self.present(dest, animated: true, completion: nil)
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
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userCats.count
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
        
        label.text = userCats[indexPath.row].name
        label2.text = String(describing: (userCats[indexPath.row].cat_feeding?.calories_today)!)
        label3.text = String(describing: (userCats[indexPath.row].cat_feeding?.calories_total)!)
        label4.text = "Delete" //volume
        label5.text = "Delete" //volume
        label8.text = "Overfed" //alert
        //        label2.text = String(calCurrent[indexPath.row])
        //        label3.text = String(calTotal[indexPath.row])
        //        label4.text = String(foodCurrent[indexPath.row])
        //        label5.text = String(foodTotal[indexPath.row])
        //        label8.text = alertInformation[indexPath.row]
        
        let calProgressBar = cell.viewWithTag(6) as! UIProgressView
        calProgressBar.progress = 1.0
        //calProgressBar.progress = Float(1.0 - ((userCats[indexPath.row].cat_feeding?.calories_today)!/(userCats[indexPath.row].cat_feeding?.calories_total)!))
        
        let foodProgressBar = cell.viewWithTag(7) as! UIProgressView
        //foodProgressBar.progress = 1 - foodProgress[indexPath.row]
        foodProgressBar.progress = 1.0
        
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
    
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let titleString = "No Cats Yet"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline), NSForegroundColorAttributeName: UIColor.white]
        return NSAttributedString(string: titleString, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let descriptionString = "Add your first cat to get started!"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body), NSForegroundColorAttributeName: UIColor.white]
        return NSAttributedString(string: descriptionString, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "catProfileDefault")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
        let buttonString = "Add A Cat"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .callout), NSForegroundColorAttributeName: UIColor.white]
        return NSAttributedString(string: buttonString, attributes: attrs)
    }
    
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "createCatView") as? catDetailsController
            else {
                print("Could not instantiate view controller with identifier of type catDetailsController")
                return
        }
        let modalNav = UINavigationController(rootViewController: vc)
        let backImage = UIImage(named: "backBtn")
        modalNav.navigationBar.backIndicatorImage = backImage
        modalNav.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        present(modalNav, animated: true, completion: nil)
    }
}

