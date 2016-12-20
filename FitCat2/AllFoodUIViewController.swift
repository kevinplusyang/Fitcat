//
//  allFoodUIViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/27/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//



import UIKit
import Foundation
import Alamofire


class allFoodUIViewController: UIViewController, UITableViewDelegate {

    var objects: NSMutableArray! = NSMutableArray()
    var data:[String] = ["food1","food2","food3","food4","food5","food6"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.objects.add("food1")
        self.objects.add("food2")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.titleLabel.text = data[indexPath.row]
        cell.shareButton.tag = indexPath.row
        return cell
    }   
}


