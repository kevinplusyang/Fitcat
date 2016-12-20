//
//  todayTableViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/29/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON


class todayTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var date:[String] = []
    var cal:[String] = []
    var food:[String] = []
    var foodLibrary:[String] = ["Beyond Grain Free Ocean Whitefish and Egg Recipe Natural Dry Cat Food","Beyond Grain Free White Meat Chicken and Egg Recipe Natural Dry Cat Food","EVO 95 Chicken and Turkey Recipe in Gravy Canned Cat Food","food4","food5","food6"]

    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request("http://mingplusyang.com/fitcatDB/getTodayRecord.php?a1=\(currentCatObj.cat_id)").responseJSON { response in
            
            if let jsonData = response.result.value {
                let json = JSON(jsonData)
                let count = json["count"].intValue
                
                var i = 0
                while i < count {
                    self.date.append(json["date"][i]["num"].stringValue)
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.cal.append("\(json["cal"][i]["num"].stringValue) Cal")
                    i = i + 1
                }
                
                i = 0
                while i < count {
                    self.food.append("\(json["food"][i]["num"].stringValue) oz")
                    i = i + 1
                }
                
                print(self.date)
                print(self.cal)
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

      func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("table:\(foodLibrary.count)")
        return date.count
    }

    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let dateLabel = cell.viewWithTag(1) as! UILabel
        dateLabel.text = date[indexPath.row]
        
        
        let calLabel = cell.viewWithTag(2) as! UILabel
        calLabel.text = cal[indexPath.row]
        
        
        let foodLabel = cell.viewWithTag(3) as! UILabel
        foodLabel.text = food[indexPath.row]
      
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
