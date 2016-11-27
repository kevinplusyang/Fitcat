//
//  amountSelectionViewController.swift
//  FitCat
//
//  Created by KY on 11/21/16.
//  Copyright © 2016 Cornell University Information Science. All rights reserved.
//

import UIKit

class amountSelectionViewController: UIViewController {
    
    @IBOutlet weak var addToBowlBtn: UIButton!
    @IBOutlet weak var FeedBtn: UIButton!
    
    @IBOutlet weak var wetDrylabel: UILabel!
    
    @IBOutlet weak var amountView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        amountView.layer.cornerRadius = 8
        wetDrylabel.layer.cornerRadius = 5
        addToBowlBtn.layer.cornerRadius = 5
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
