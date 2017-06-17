//
//  CatDetailsViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 4/5/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class CatDetailsViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var currentCat: CreateCatModel!
    var scrollView: UIScrollView!
    var catImageView: UIImageView!
    var catCirclePercent: KDCircularProgress!
    var catCirclePercentLabel: UILabel!
    var currentLabel: UILabel!
    var currentWeightLabel: UILabel!
    var currentBCSLabel: UILabel!
    var goalLabel: UILabel!
    var goalWeightLabel: UILabel!
    var goalBCSLabel: UILabel!
    
    var feedingOrWeightSegmentedControl: SMSegmentView!
    var topSegmentControlLayer: CALayer!
    var bottomSegmentControlLayer: CALayer!
    
    var smallSegmentedControl: UISegmentedControl!
    
    var calorieView: UIView!
    var intakeCaloriesLabel: UILabel!
    var intakeCaloriesNumberLabel: UILabel!
    var caloriesRemainingLabel: UILabel!
    var caloriesRemainingNumberLabel: UILabel!
    var calorieProgressBar: UIProgressView!
    
    var logAFeedingButton: UIButton!
    
    var tableView: UITableView!
    
    var graphMonthView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        UIApplication.shared.statusBarView?.backgroundColor = .fitcatOrange
        navigationController?.navigationBar.backgroundColor = .fitcatOrange
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "food_market"), style: .plain, target: self, action: #selector(clickedFoodMarket))
        title = currentCat.catName
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        view.backgroundColor = .white
        
        
        setUpView()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView() {
        
        scrollView = UIScrollView(frame: view.frame)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 300)
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        catImageView = UIImageView(frame: CGRect(x: 0.0, y: 40.0, width: 83.5, height: 83.5))
        catImageView.layer.cornerRadius = catImageView.bounds.height / 2.0
        catImageView.layer.masksToBounds = true
        catImageView.center.x = view.center.x
        catImageView.image = UIImage(data: currentCat.catPictureData)
        scrollView.addSubview(catImageView)
        
        catCirclePercent = KDCircularProgress(frame: CGRect(x: 0.0, y: 0.0, width: 170.0, height: 170.0))
        catCirclePercent.center = catImageView.center
        catCirclePercent.startAngle = 90.0
        catCirclePercent.progressThickness = 0.25
        catCirclePercent.trackThickness = 0.3
        catCirclePercent.clockwise = true
        catCirclePercent.set(colors: .fitcatProgressGreen)
        catCirclePercent.trackColor = .fitcatProgressGray
        catCirclePercent.progress = 0.31
        scrollView.addSubview(catCirclePercent)
        
        catCirclePercentLabel = UILabel()
        catCirclePercentLabel.text = "31%"
        catCirclePercentLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        catCirclePercentLabel.textColor = UIColor(white: 100.0 / 255.0, alpha: 1.0)
        catCirclePercentLabel.backgroundColor = .white
        catCirclePercentLabel.sizeToFit()
        catCirclePercentLabel.layer.cornerRadius = catCirclePercentLabel.bounds.height / 2.0
        catCirclePercentLabel.layer.borderColor = UIColor.white.cgColor
        catCirclePercentLabel.layer.borderWidth = 4.0
        catCirclePercentLabel.layer.masksToBounds = true
        catCirclePercentLabel.frame = CGRect(x: 0.0, y: 0.0, width: catCirclePercentLabel.bounds.width + 18.0, height: catCirclePercentLabel.bounds.height + 4.0)
        catCirclePercentLabel.textAlignment = .center
        catCirclePercentLabel.center.x = view.center.x
        catCirclePercentLabel.center.y = catCirclePercent.frame.maxY - 20.0
        
        scrollView.addSubview(catCirclePercentLabel)
        
        currentWeightLabel = UILabel()
        currentWeightLabel.textColor = UIColor(white: 100.0 / 255.0, alpha: 1.0)
        currentWeightLabel.text = "\(String(describing: (currentCat.catFeeding.currentWeight).kilogramsToPounds().roundTo(places: 1))) lbs"
        currentWeightLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        currentWeightLabel.textAlignment = .center
        currentWeightLabel.sizeToFit()
        currentWeightLabel.center.x = catCirclePercent.frame.minX * 0.60
        currentWeightLabel.center.y = catImageView.center.y
        scrollView.addSubview(currentWeightLabel)
        
        currentLabel = UILabel()
        currentLabel.text = "Current"
        currentLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        currentLabel.textColor = UIColor(white: 100.0 / 255.0, alpha: 1.0)
        currentLabel.sizeToFit()
        currentLabel.center.x = currentWeightLabel.center.x
        currentLabel.center.y = currentWeightLabel.frame.minY - 20.0
        scrollView.addSubview(currentLabel)
        
        currentBCSLabel = UILabel()
        currentBCSLabel.textColor = UIColor(white: 100.0 / 255.0, alpha: 1.0)
        currentBCSLabel.text = "\(String(describing: currentCat.catInitialBCS)) BCS"
        currentBCSLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        currentBCSLabel.sizeToFit()
        currentBCSLabel.center.x = currentWeightLabel.center.x
        currentBCSLabel.center.y = currentWeightLabel.frame.maxY + 20.0
        scrollView.addSubview(currentBCSLabel)
        
        goalWeightLabel = UILabel()
        goalWeightLabel.textColor = UIColor(white: 100.0 / 255.0, alpha: 1.0)
        goalWeightLabel.text = "\(String(describing: (currentCat.catFeeding.goalWeight).kilogramsToPounds().roundTo(places: 1))) lbs"
        goalWeightLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        goalWeightLabel.sizeToFit()
        goalWeightLabel.center.x = view.bounds.width - (catCirclePercent.frame.minX * 0.60)
        goalWeightLabel.center.y = currentWeightLabel.center.y
        scrollView.addSubview(goalWeightLabel)
        
        goalLabel = UILabel()
        goalLabel.text = "Goal"
        goalLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        goalLabel.textColor = UIColor(white: 100.0 / 255.0, alpha: 1.0)
        goalLabel.sizeToFit()
        goalLabel.center.x = goalWeightLabel.center.x
        goalLabel.center.y = currentLabel.center.y
        scrollView.addSubview(goalLabel)
        
        goalBCSLabel = UILabel()
        goalBCSLabel.textColor = UIColor(white: 100.0 / 255.0, alpha: 1.0)
        goalBCSLabel.text = "\(String(describing: currentCat.catFeeding.goalBcs)) BCS"
        goalBCSLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        goalBCSLabel.sizeToFit()
        goalBCSLabel.center.x = goalWeightLabel.center.x
        goalBCSLabel.center.y = currentBCSLabel.center.y
        scrollView.addSubview(goalBCSLabel)
        
        let segmentedControlAppearance = SMSegmentAppearance()
        segmentedControlAppearance.contentVerticalMargin = 10.0
        segmentedControlAppearance.segmentOffSelectionColour = .white
        segmentedControlAppearance.segmentOnSelectionColour = .white
        segmentedControlAppearance.titleOnSelectionColour = .fitcatOrange
        segmentedControlAppearance.titleOffSelectionColour = UIColor(white: 155.0 / 255.0, alpha: 1.0)
        segmentedControlAppearance.titleOnSelectionFont = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        segmentedControlAppearance.titleOffSelectionFont = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        
        
        let segmentControlFrame = CGRect(x: 0.0, y: catCirclePercentLabel.frame.maxY + 30.0, width: view.bounds.width, height: 55.0)
        feedingOrWeightSegmentedControl = SMSegmentView(frame: segmentControlFrame, dividerColour: UIColor(white: 180.0 / 255.0, alpha: 1.0), dividerWidth: 0.5, segmentAppearance: segmentedControlAppearance)
        feedingOrWeightSegmentedControl.addTarget(self, action: #selector(changedMainSegmentControl), for: .valueChanged)
        feedingOrWeightSegmentedControl.addSegmentWithTitle("Feeding", onSelectionImage: #imageLiteral(resourceName: "segmentFoodRed"), offSelectionImage: #imageLiteral(resourceName: "foodGray"))
        feedingOrWeightSegmentedControl.addSegmentWithTitle("Weight", onSelectionImage: #imageLiteral(resourceName: "weightOrange"), offSelectionImage: #imageLiteral(resourceName: "segmentWeightGray"))
        
        scrollView.addSubview(feedingOrWeightSegmentedControl)
        
        topSegmentControlLayer = CALayer()
        topSegmentControlLayer.frame = CGRect(x: 0.0, y: feedingOrWeightSegmentedControl.frame.minY, width: view.bounds.width, height: 0.5)
        topSegmentControlLayer.backgroundColor = UIColor(white: 180.0 / 255.0, alpha: 1.0).cgColor
        scrollView.layer.addSublayer(topSegmentControlLayer)
        
        bottomSegmentControlLayer = CALayer()
        bottomSegmentControlLayer.frame = CGRect(x: 0.0, y: feedingOrWeightSegmentedControl.frame.maxY, width: view.bounds.width, height: 0.5)
        bottomSegmentControlLayer.backgroundColor = UIColor(white: 180.0 / 255.0, alpha: 1.0).cgColor
        scrollView.layer.addSublayer(bottomSegmentControlLayer)
        
        feedingOrWeightSegmentedControl.selectedSegmentIndex = 0
        
        let items = ["Today", "Month", "Year"]
        smallSegmentedControl = UISegmentedControl(items: items)
        smallSegmentedControl.addTarget(self, action: #selector(changedSmallSegmentControl), for: .valueChanged)
        smallSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(white: 155.0 / 255.0, alpha: 1.0)], for: .normal)
        smallSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)
        smallSegmentedControl.setDividerImage(UIImage().colored(with: .clear, size: CGSize(width: 1, height: smallSegmentedControl.frame.height)), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        smallSegmentedControl.tintColor = .fitcatOrange
        smallSegmentedControl.layer.borderWidth = 1.0
        smallSegmentedControl.layer.borderColor = UIColor(white: 155.0 / 255.0, alpha: 1.0).cgColor
        smallSegmentedControl.layer.cornerRadius = 4.0
        smallSegmentedControl.backgroundColor = UIColor(white: 244.0 / 255.0, alpha: 1.0)
        smallSegmentedControl.setWidth(90.0, forSegmentAt: 0)
        smallSegmentedControl.setWidth(90.0, forSegmentAt: 1)
        smallSegmentedControl.setWidth(90.0, forSegmentAt: 2)
        smallSegmentedControl.center.x = view.center.x
        smallSegmentedControl.center.y = bottomSegmentControlLayer.frame.maxY + 15.0 + (smallSegmentedControl.bounds.height / 2.0)
        
        smallSegmentedControl.selectedSegmentIndex = 0
        
        scrollView.addSubview(smallSegmentedControl)
        
        calorieView = UIView(frame: CGRect(x: 0.0, y: smallSegmentedControl.frame.maxY + 30.0, width: view.frame.size.width, height: 122.0))
        calorieView.backgroundColor = UIColor(white: 244.0 / 255.0, alpha: 1.0)
        
        intakeCaloriesLabel = UILabel()
        caloriesRemainingLabel = UILabel()
        
        intakeCaloriesLabel.text = "Intake Calories"
        caloriesRemainingLabel.text = "Calories Remaining"
        
        intakeCaloriesLabel.textColor = UIColor(white: 124.0 / 255.0, alpha: 1.0)
        caloriesRemainingLabel.textColor = UIColor(white: 124.0 / 255.0, alpha: 1.0)
        
        intakeCaloriesLabel.font = .systemFont(ofSize: 13)
        caloriesRemainingLabel.font = .systemFont(ofSize: 13)
        
        intakeCaloriesLabel.sizeToFit()
        caloriesRemainingLabel.sizeToFit()
        
        
        intakeCaloriesLabel.center.x = calorieView.bounds.width * 0.25
        caloriesRemainingLabel.center.x = calorieView.bounds.width * 0.75
        
        intakeCaloriesLabel.center.y = calorieView.bounds.height * 0.2
        caloriesRemainingLabel.center.y = calorieView.bounds.height * 0.2
        
        calorieView.addSubview(intakeCaloriesLabel)
        calorieView.addSubview(caloriesRemainingLabel)

        intakeCaloriesNumberLabel = UILabel()
        caloriesRemainingNumberLabel = UILabel()
        
        intakeCaloriesNumberLabel.text = "0"
        caloriesRemainingNumberLabel.text = String(describing: Int((currentCat.catPlan.catCalories)!))
        intakeCaloriesNumberLabel.textColor = .fitcatLightGrayText
        caloriesRemainingNumberLabel.textColor = .fitcatLightGrayText
        
        intakeCaloriesNumberLabel.font = .boldSystemFont(ofSize: 20)
        caloriesRemainingNumberLabel.font = .boldSystemFont(ofSize: 20)
        
        intakeCaloriesNumberLabel.sizeToFit()
        caloriesRemainingNumberLabel.sizeToFit()
        
        intakeCaloriesNumberLabel.center.y = calorieView.bounds.midY
        caloriesRemainingNumberLabel.center.y = calorieView.bounds.midY
        
        intakeCaloriesNumberLabel.center.x = intakeCaloriesLabel.center.x
        caloriesRemainingNumberLabel.center.x = caloriesRemainingLabel.center.x
        
        calorieView.addSubview(intakeCaloriesNumberLabel)
        calorieView.addSubview(caloriesRemainingNumberLabel)
        
        calorieProgressBar = UIProgressView(frame: CGRect(x: 0.0, y: 0.0, width: calorieView.bounds.width * 0.68, height: 14.0))
        calorieProgressBar.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        calorieProgressBar.layer.cornerRadius = 3.0
        calorieProgressBar.layer.masksToBounds = true
        calorieProgressBar.progressTintColor = .fitcatProgressGreen
        calorieProgressBar.trackTintColor = .fitcatProgressGray
        calorieProgressBar.progress = 0.5
        calorieProgressBar.center.x = view.center.x
        calorieProgressBar.center.y = calorieView.bounds.maxY - (intakeCaloriesLabel.center.y)
        calorieView.addSubview(calorieProgressBar)
        
        scrollView.addSubview(calorieView)
        
        let tableViewHeight = view.bounds.height - (calorieView.frame.maxY - feedingOrWeightSegmentedControl.frame.minY)
        let tableViewFrame = CGRect(x: 0.0, y: calorieView.frame.maxY, width: view.bounds.width, height: tableViewHeight)
        tableView = UITableView(frame: tableViewFrame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
        tableView.register(CatDetailTableViewCell.self, forCellReuseIdentifier: "catFoodCell")
        
        
        scrollView.addSubview(tableView)
        
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        logAFeedingButton = UIButton()
        logAFeedingButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        logAFeedingButton.center.x = view.center.x
        logAFeedingButton.backgroundColor = .fitcatOrange
        logAFeedingButton.layer.cornerRadius = 7
        logAFeedingButton.setTitle("Log a feeding", for: .normal)
        logAFeedingButton.addTarget(self, action: #selector(logAFeeding), for: .touchUpInside)
        view.addSubview(logAFeedingButton)
        
        
        graphMonthView = UIView(frame: CGRect(x: 0.0, y: smallSegmentedControl.frame.maxY + 30.0, width: view.frame.size.width, height: 200.0))
        graphMonthView.backgroundColor = UIColor(white: 244.0 / 255.0, alpha: 1.0)
        graphMonthView.isHidden = true
        scrollView.addSubview(graphMonthView)
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /*let yOffset = scrollView.contentOffset.y
        print(yOffset)
        if scrollView == self.scrollView {
            if yOffset + 1.0 >= feedingOrWeightSegmentedControl.frame.minY - ((navigationController?.navigationBar.bounds.height)! + UIApplication.shared.statusBarFrame.height){
                
                self.scrollView.isScrollEnabled = false
                self.tableView.isScrollEnabled = true
            }
        }
        if scrollView == self.tableView {
            if yOffset <= 0.5 {
                self.scrollView.isScrollEnabled = true
                self.tableView.isScrollEnabled = false
            }
        } */
    }
    
    func changedSmallSegmentControl(sender: UISegmentedControl) {
        print("changed small segmentControl")
        if sender.selectedSegmentIndex == 0 {
            tableView.isHidden = false
            calorieView.isHidden = false
            intakeCaloriesLabel.isHidden = false
            intakeCaloriesNumberLabel.isHidden = false
            caloriesRemainingLabel.isHidden = false
            caloriesRemainingNumberLabel.isHidden = false
            calorieProgressBar.isHidden = false
            
            graphMonthView.isHidden = true
        }
        
        if sender.selectedSegmentIndex == 1 { //selectedMonth Tab
            tableView.isHidden = true
            calorieView.isHidden = true
            intakeCaloriesLabel.isHidden = true
            intakeCaloriesNumberLabel.isHidden = true
            caloriesRemainingLabel.isHidden = true
            caloriesRemainingNumberLabel.isHidden = true
            calorieProgressBar.isHidden = true
            
            graphMonthView.isHidden = false
            
        }
    }
    
    func changedMainSegmentControl() {
        print("ChangedMainSegmentControl")
    }
    
    
    
    func clickedFoodMarket() {
        
    }
    
    func logAFeeding(sender: UIButton) {
        let widthAndHeight = view.bounds.width * 0.32
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 40, bottom: 10, right: 40)
        flowLayout.minimumLineSpacing = 70.0
        flowLayout.itemSize = CGSize(width: widthAndHeight ,height: widthAndHeight) //32%
        let pantryVC = PantryCollectionViewController(collectionViewLayout: flowLayout)
        pantryVC.cat = currentCat
        navigationController?.pushViewController(pantryVC, animated: true)
    }
    
    //Tableview datasource
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catFoodCell") as! CatDetailTableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
}
