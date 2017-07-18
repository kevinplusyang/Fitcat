//
//  FoodMarketViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/24/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit
import Firebase
import DZNEmptyDataSet

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
        FIRDatabase.database().reference().child("foods").observe(.value, with: { (snapshot) in
            self.foodOptions = []
            if let foodArray = snapshot.value as? NSArray {
                print("FOOD ARRAY COUNT", foodArray.count)
                for foodItem in foodArray {
                    print("In array")

                    if let foodDictionary = foodItem as? NSDictionary {
                        if
                            let foodName = foodDictionary["name"] as? String,
                            let style = foodDictionary["style"] as? String,
                            let moisturePercent = foodDictionary["moisturePercent"] as? Double,
                            let carbPercent = foodDictionary["carbPercent"] as? Double,
                            let fatPercent = foodDictionary["fatPercent"] as? Double,
                            let fiberPercent = foodDictionary["fiberPercent"] as? Double,
                            let protienPercent = foodDictionary["proteinPercent"] as? Double,
                            let kcalPerKg = foodDictionary["kcalPerKg"] as? Int {
                            if style == "wet" {
                                var finished = false
                                var foodImage = "unknown"
                                if let imageBase64 = foodDictionary["image"] as? String {
                                    foodImage = imageBase64
                                }
                                if let wetCalPerCup2 = foodDictionary["kcalPerCup"] as? [[String:String]] {

                                    let foodItem = FoodModel(foodName: foodName, style: style, moisturePercent: moisturePercent, carbPercent: Int(carbPercent), fatPercent: fatPercent, fiberPercent: fiberPercent, proteinPercent: Int(protienPercent), dryKCalPerCup: nil, wetKCalPerCup: wetCalPerCup2, kcalPerKg: kcalPerKg, image: foodImage)
                                    print("added wet food item2!")
                                    self.foodOptions.append(foodItem)
                                    finished = true
                                    print(wetCalPerCup2)

                                }
                                if
                                    !finished,
                                    let wetCalPerCup = foodDictionary["kcalPerCup"] as? [String:String] {
                                    let foodItem = FoodModel(foodName: foodName, style: style, moisturePercent: moisturePercent, carbPercent: Int(carbPercent), fatPercent: fatPercent, fiberPercent: fiberPercent, proteinPercent: Int(protienPercent), dryKCalPerCup: nil, wetKCalPerCup: [wetCalPerCup], kcalPerKg: kcalPerKg, image: foodImage)
                                    self.foodOptions.append(foodItem)
                                    print("added wet food item!")
                                    print(wetCalPerCup)

                                }

                            } else {
                                var dryFoodImage = "unknown"
                                if let dryKCalPerCup = foodDictionary["kcalPerCup"] as? Int {
                                    if
                                        let imageBase64 = foodDictionary["image"] as? String {
                                        print("GETTING FOOD RESULT IMAGE", imageBase64)
                                        dryFoodImage = imageBase64
                                    }
                                    let foodItem = FoodModel(foodName: foodName, style: style, moisturePercent: moisturePercent, carbPercent: Int(carbPercent), fatPercent: fatPercent, fiberPercent: fiberPercent, proteinPercent: Int(protienPercent), dryKCalPerCup: dryKCalPerCup, wetKCalPerCup: nil, kcalPerKg: kcalPerKg, image: dryFoodImage)
                                    print("added foodItem")
                                    self.foodOptions.append(foodItem)
                                }
                            }
                        } else {
                            print("Failed if let")
                            print("FOOD DICTIONARY", foodDictionary)
                        }

                    } else {

                    }

                }
            }
            print("FOOD COUNT", self.foodOptions.count)
            self.tableView.reloadData()
        })
    }

    func donePressed() {
        if let user = FIRAuth.auth()?.currentUser {
            let foodRef = FIRDatabase.database().reference().child("users").child(user.uid).child("foodCollection")
            for foodItem in selectedFood {
                let strBase64 = foodItem.image
                print("SAVING IMAGE TO MY FOOD COLLECTION", strBase64)
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                let url = NSURL(fileURLWithPath: path)
                let foodPath = url.appendingPathComponent(foodItem.foodName.camelcaseStringLowerCase + ".png")!
                if !FileManager.default.fileExists(atPath: foodPath.path) {
                    print("File does not exist at path: ", foodPath.path)
                    downloadImage(urlString: foodItem.image) { (imageData) -> Void in
                        if let data = imageData {
                            try? data.write(to: foodPath)
                        }
                    }
                }

                if foodItem.style == "wet" {
                    let foodParams: [String: Any] = ["name": foodItem.foodName, "carbPercent": foodItem.carbPercent, "fatPercent": foodItem.fatPercent, "fiberPercent": foodItem.fiberPercent, "kcalPerCup": foodItem.wetKCalPerCup, "kcalPerKg": foodItem.kcalPerKg, "moisturePercent": foodItem.moisturePercent, "proteinPercent": foodItem.protienPercent, "style": foodItem.style, "image": strBase64]
                    foodRef.childByAutoId().setValue(foodParams)
                } else {
                    let foodParams: [String: Any] = ["name": foodItem.foodName, "carbPercent": foodItem.carbPercent, "fatPercent": foodItem.fatPercent, "fiberPercent": foodItem.fiberPercent, "kcalPerCup": foodItem.dryKCalPerCup, "kcalPerKg": foodItem.kcalPerKg, "moisturePercent": foodItem.moisturePercent, "proteinPercent": foodItem.protienPercent, "style": foodItem.style, "image": strBase64]
                    foodRef.childByAutoId().setValue(foodParams)
                }
            }
        }
        navigationController?.popViewController(animated: true)

    }

    //SearchBar Delegates
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        parseFoodOptions = foodOptions.filter({$0.foodName.smartContains(searchText)})
    }

    //TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseFoodOptions.count
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        // Create the headers for the tableView
        let sectionTitlesWithDuplicates = foodOptions.map({ $0.foodName.capitalized.substring(to: $0.foodName.index($0.foodName.startIndex, offsetBy: 1))})
        let sectionTitlesWithoutDuplicates = Array(Set(sectionTitlesWithDuplicates))
        return sectionTitlesWithoutDuplicates
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodSearch") as? FoodSearchTableViewCell else { return UITableViewCell() }
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
