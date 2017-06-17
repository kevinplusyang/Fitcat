//
//  FoodMarketViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/24/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit
import Firebase

class FoodMarketViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource {
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    var foodOptions: [FoodModel] = []
    var selectedFood: [FoodModel] = []
    var parseFoodOptions: [FoodModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getFoodResults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarView?.backgroundColor = .fitcatOrange
        navigationController?.navigationBar.backgroundColor = .fitcatOrange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Food Market"
        
        //navBar done button
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        navigationItem.rightBarButtonItem = doneBarButton
        
        let searchBarFrame = CGRect(x: 0.0, y: (navigationController?.navigationBar.bounds.maxY)! + 30.0, width: view.bounds.width * 0.78, height: 44.0)
        searchBar = UISearchBar(frame: searchBarFrame)
        searchBar.delegate = self
        searchBar.center.x = view.center.x
        searchBar.placeholder = "Search"
        searchBar.barTintColor = .white
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
        searchBar.backgroundColor = .white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        
        
        let tableViewFrame = CGRect(x: 0.0, y: searchBar.frame.maxY, width: view.bounds.width, height: view.bounds.height - searchBar.frame.maxY)
        tableView = UITableView(frame: tableViewFrame, style: .grouped)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.backgroundColor = .white
        
        tableView.register(FoodSearchTableViewCell.self, forCellReuseIdentifier: "foodSearch")
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFoodResults() {
        FIRDatabase.database().reference().child("foods").observeSingleEvent(of: .value, with: { (snapshot) in
            if let foodArray = snapshot.value as? NSArray {
                for foodItem in foodArray {
                    if let foodDictionary = foodItem as? NSDictionary {
                        //if let name = foodDictionary["Name"] as? String, let protein = foodDictionary["Protein %"] as? Int, let moisture = foodDictionary["Moisture"] as? Int, let kCalPerKG = foodDictionary["Kcal per Kg"] as? Int, let kCalPerCup = foodDictionary["Kcal per Cup"] as? String, let fiber = foodDictionary["Fiber %"] as? Int, let fat = foodDictionary["Fat %"] as? Int, let carb = foodDictionary["Carb %"] as? Int {
                        if let name = foodDictionary["Name"] as? String, let caloriesPerCup = foodDictionary["Kcal per Cup"] as? String {
                            if let caloriesPerCupInt = Int(caloriesPerCup) {
                                let caloriesPerCupDouble = Double(caloriesPerCupInt)
                                let foodObject = FoodModel(foodName: name, caloriesPerCup: caloriesPerCupDouble)
                                self.foodOptions.append(foodObject)
                            }
                            
                        }
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func donePressed() {
        if let user = FIRAuth.auth()?.currentUser {
            let foodRef = FIRDatabase.database().reference().child("users").child(user.uid).child("foodCollection")
            for foodItem in selectedFood {
                let foodParams: [String: Any] = ["foodName": foodItem.foodName, "caloriesPerCup": foodItem.caloriesPerCup]
                foodRef.childByAutoId().setValue(foodParams)
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    //SearchBar Delegates
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        parseFoodOptions = foodOptions.filter({$0.foodName.contains(searchText)})
    }
    
    //TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseFoodOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodSearch") as! FoodSearchTableViewCell
        cell.textLabel?.text = parseFoodOptions[indexPath.row].foodName
        cell.accessoryType = selectedFood.contains(parseFoodOptions[indexPath.row]) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedFood.contains(parseFoodOptions[indexPath.row]) {
            selectedFood = selectedFood.filter({ $0 != parseFoodOptions[indexPath.row] })
        } else {
            selectedFood.append(parseFoodOptions[indexPath.row]) }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    //Empty TableView
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "Search For Cat Food"
        return NSAttributedString(string: title)
    }
    
}
