//
//  foodMarketTableViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/26/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire


class foodMarketTableViewController: UITableViewController{
    
    //temp data placeholder
    
  
    
    var data:[String] = ["Beyond Grain Free Ocean Whitefish and Egg Recipe Natural Dry Cat Food","Beyond Grain Free White Meat Chicken and Egg Recipe Natural Dry Cat Food","EVO 95 Chicken and Turkey Recipe in Gravy Canned Cat Food","food4","food5","food6"]
    var data2:[String] = ["Add to favorite","Add to favorite","Add to favorite","Add to favorite","Add to favorite","Add to favorite","Add to favorite"]
    var images = [UIImage(named:"food1"),UIImage(named:"food1"),UIImage(named:"food2"),UIImage(named:"food1"),UIImage(named:"food1"),UIImage(named:"food1"),UIImage(named:"food1")]
    
    var selectedData:String = ""
    
   
    

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        Alamofire.request("http://www.mingplusyang.com/fitcatDB/getFavoriteStatus.php?a1=1").responseJSON { response in
            print("alo")
            print("Request: \(response.request)")
            print("Response: \(response.response)")
           
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                
                
                var count = json["count"].intValue
                print("JJSON:\(count)")
                var i = 0
                while i < count {
                    self.data2[json["foods"][i]["id"].intValue] = "Added"
                    i = i + 1
                }

                print("ssss:\(self.data2)")
                self.tableView.reloadData()
                
            }
        }

        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        Alamofire.request("http://mingplusyang.com/fitcatDB/changeFavorite.php?a1=1&a2=\(Int(indexPath.row)+1)").response { response in
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                var result = 0
                print("Data: \(utf8Text)")

                if(self.data2[Int(indexPath.row)] == "Add to favorite"){
                    self.data2[Int(indexPath.row)] = "Added"
                } else if(self.data2[Int(indexPath.row)] == "Added"){
                    self.data2[Int(indexPath.row)] = "Add to favorite"
                }
                
                self.tableView.reloadData()
                
            }
        }
        
        
        print("rowselected:\(indexPath.row)")

        
        

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        let label = cell.viewWithTag(1) as! UILabel
        let label2 = cell.viewWithTag(2) as! UILabel
        label2.text = data2[indexPath.row]
        label.text = data[indexPath.row]
        
        cell.imageView?.image = images[indexPath.row]
        return cell
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
