//
//  planOverviewControllerViewController.swift
//  FitCat2
//
//  Created by Ming Yang on 11/23/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos

class PlanOverviewControllerViewController: UIViewController {

    let catImageView = UIImageView()
    let startDate = UILabel()
    let endDate = UILabel()
    let weightToLoseNumber = UILabel()
    let weightToLose = UILabel()
    let weightToLosePerMonth = UILabel()
    let weightToLosePerMonthNumber = UILabel()
    let caloriesPerDay = UILabel()
    let caloriesPerDayNumber = UILabel()
    let endDateBig = UILabel()
    let letsGoButton = UIButton()
    let finalGoalLabel = UILabel()
    let finalGoalWeightLabel = UILabel()
    let lineBelowGoal = CALayer()
    let lineBelowDates = CALayer()
    let lineBelowTotalWeight = CALayer()
    let lineBelowReccomendedWeight = CALayer()
    let lineBelowTotalCalories = CALayer()
    let userDefaults = UserDefaults.standard


    var cat: CreateCatModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //cat image
        title = "Plan Overview for \(cat.catName)"
        view.backgroundColor = UIColor(red: 93/255, green: 92/255, blue: 92/255, alpha: 1.0)
        setUpView()



        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short

        self.startDate.text = dateFormatter.string(from: (self.cat.catPlan.planStartDate)!)
        self.endDate.text = dateFormatter.string(from: (self.cat.catPlan.planEndDate)!)
        self.endDateBig.text = dateFormatter.string(from: (self.cat.catPlan.planEndDate)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpView() {
        let navigationHeight = navigationController!.navigationBar.bounds.height

        //Continue Button
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        letsGoButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        letsGoButton.center.x = view.center.x
        letsGoButton.layer.borderWidth = 2.0
        letsGoButton.layer.borderColor = UIColor.white.cgColor
        letsGoButton.layer.cornerRadius = 7
        letsGoButton.setTitle("Let's Go!", for: .normal)
        letsGoButton.addTarget(self, action: #selector(letsGoButtonClicked), for: .touchUpInside)
        view.addSubview(letsGoButton)

        catImageView.frame = CGRect(x: 0.0, y: navigationHeight + 30.0, width: view.bounds.height * 0.125, height: view.bounds.height * 0.125)
        catImageView.layer.borderWidth = 1
        catImageView.layer.masksToBounds = false
        catImageView.layer.borderColor = UIColor.white.cgColor
        catImageView.layer.cornerRadius = catImageView.frame.height/2
        catImageView.clipsToBounds = true
        catImageView.center.x = view.center.x
        if let catPictureData = cat.catPictureData {
            catImageView.image = UIImage(data: catPictureData)
        } else { catImageView.backgroundColor = .blue }
        //catImageView.image = UIImage(data: cat.catPictureData)
        view.addSubview(catImageView)

        let pounds = userDefaults.bool(forKey: "pounds")

        finalGoalWeightLabel.textColor = .white
        let goalWeight = self.cat.catFeeding.goalWeight
        let currentWeight = self.cat.catFeeding.currentWeight
        let finalGoalInPounds = (goalWeight.kilogramsToPounds().trim2Decimals())
        let finalGoalWeightInKilos = (goalWeight.trim2Decimals())
        finalGoalWeightLabel.text = pounds ? "\(finalGoalInPounds)lb BCS 5" : "\(finalGoalWeightInKilos)kilograms BCS 5"
        finalGoalWeightLabel.sizeToFit()
        finalGoalWeightLabel.center.x = view.center.x
        finalGoalWeightLabel.center.y = catImageView.frame.maxY + finalGoalWeightLabel.bounds.height + 8.0
        view.addSubview(finalGoalWeightLabel)

        finalGoalLabel.text = "Final Goal"
        finalGoalLabel.textColor = .white
        finalGoalLabel.sizeToFit()
        finalGoalLabel.frame = CGRect(x: finalGoalWeightLabel.frame.minX - finalGoalLabel.bounds.width - 15.0, y: finalGoalWeightLabel.frame.minY, width: 20, height: 10)
        finalGoalLabel.sizeToFit()
        view.addSubview(finalGoalLabel)

        let width = view.bounds.width * 0.4
        lineBelowGoal.backgroundColor = UIColor.white.cgColor
        let xCoord = view.bounds.width * 0.3
        lineBelowGoal.frame = CGRect(x: xCoord, y: finalGoalLabel.frame.maxY + 8.0, width: width, height: 1)
        view.layer.addSublayer(lineBelowGoal)

        let spaceBetweenEachLine = (letsGoButton.frame.minY - lineBelowGoal.frame.maxY) / 5.0
        let lineWidth = view.bounds.width * 0.8
        let indent = view.bounds.width * 0.1

        lineBelowDates.backgroundColor = UIColor.white.cgColor
        lineBelowDates.frame = CGRect(x: indent, y: lineBelowGoal.frame.maxY + spaceBetweenEachLine, width: lineWidth, height: 1)
        view.layer.addSublayer(lineBelowDates)

        lineBelowTotalWeight.backgroundColor = UIColor.white.cgColor
        lineBelowTotalWeight.frame = CGRect(x: indent, y: lineBelowDates.frame.maxY + spaceBetweenEachLine, width: lineWidth, height: 1)
        view.layer.addSublayer(lineBelowTotalWeight)

        lineBelowReccomendedWeight.backgroundColor = UIColor.white.cgColor
        lineBelowReccomendedWeight.frame = CGRect(x: indent, y: lineBelowTotalWeight.frame.maxY + spaceBetweenEachLine, width: lineWidth, height: 1)
        view.layer.addSublayer(lineBelowReccomendedWeight)

        lineBelowTotalCalories.backgroundColor = UIColor.white.cgColor
        lineBelowTotalCalories.frame = CGRect(x: indent, y: lineBelowReccomendedWeight.frame.maxY + spaceBetweenEachLine, width: lineWidth, height: 1)
        view.layer.addSublayer(lineBelowTotalCalories)

        //Start date and end date
        startDate.textColor = .white
        endDate.textColor = .white

        startDate.frame = CGRect(x: finalGoalLabel.frame.minX, y: 0.0, width: 100.0, height: 15.0)
        endDate.frame = CGRect(x: view.bounds.width - finalGoalLabel.frame.minX - 100.0, y: 0, width: 100.0, height: 15.0)

        let centerOfDates = ((lineBelowDates.frame.minY - lineBelowGoal.frame.maxY) / 2.0) + lineBelowGoal.frame.maxY

        startDate.center.y = centerOfDates
        endDate.center.y = centerOfDates

        print("center of dates:",centerOfDates)
        print("startDateFrame:", startDate)
        print("endDateFrame:", endDate)

        view.addSubview(startDate)
        view.addSubview(endDate)




        //total weight needed to lose
        weightToLose.textColor = .white
        weightToLose.text = "Total Weight Needed To Lose"
        weightToLose.sizeToFit()

        weightToLoseNumber.textColor = .white
        weightToLoseNumber.font = UIFont.boldSystemFont(ofSize: 24)
        weightToLoseNumber.text = pounds ? "\((self.cat.catPlan.catTotalWeightLoss)!.kilogramsToPounds().trim2Decimals()) lbs" : "\((self.cat.catPlan.catTotalWeightLoss)!.trim2Decimals()) kilograms"
        weightToLoseNumber.sizeToFit()




        let centerPoint = ((lineBelowTotalWeight.frame.minY - lineBelowDates.frame.maxY) / 2.0) + lineBelowDates.frame.minY
        print("line below total weight",lineBelowTotalWeight.frame.minY)
        print("line below dates", lineBelowDates.frame.maxY)
        print("centerPoint", centerPoint)
        let heightIndentForSections = spaceBetweenEachLine * 0.10




        weightToLose.center.x = view.center.x
        weightToLose.center.y = lineBelowDates.frame.maxY + heightIndentForSections + (weightToLose.bounds.height / 2.0)
        weightToLoseNumber.center.x = view.center.x
        weightToLoseNumber.center.y = lineBelowTotalWeight.frame.minY - heightIndentForSections - (weightToLoseNumber.bounds.height / 2.0)
        print(view.frame)
        print(weightToLose.frame)
        print(weightToLoseNumber.frame)


        weightToLosePerMonthNumber.textColor = .white
        weightToLosePerMonthNumber.font = UIFont.boldSystemFont(ofSize: 24)
        weightToLosePerMonthNumber.text = pounds ? "\((self.cat.catPlan.catWeightLossPerMonth)!.kilogramsToPounds().trim2Decimals()) lbs"  : "\((self.cat.catPlan.catWeightLossPerMonth)!.trim2Decimals()) kilograms"
        weightToLosePerMonthNumber.sizeToFit()

        weightToLosePerMonth.textColor = .white
        weightToLosePerMonth.text = "Recommended Weight Loss Per Month"
        weightToLosePerMonth.sizeToFit()



        weightToLosePerMonth.center.x = view.center.x
        let heightOfWeightToLosePerMonthHalf = weightToLosePerMonth.bounds.height / 2.0
        weightToLosePerMonth.center.y = lineBelowTotalWeight.frame.maxY + heightIndentForSections + heightOfWeightToLosePerMonthHalf

        weightToLosePerMonthNumber.center.x = view.center.x
        weightToLosePerMonthNumber.center.y = lineBelowReccomendedWeight.frame.minY - heightOfWeightToLosePerMonthHalf - heightOfWeightToLosePerMonthHalf
        caloriesPerDayNumber.textColor = .white
        caloriesPerDayNumber.font = UIFont.systemFont(ofSize: 24)
        caloriesPerDayNumber.text = "\((self.cat.catPlan.catCalories)!.trim2Decimals()) Cal"
        caloriesPerDayNumber.sizeToFit()

        caloriesPerDay.textColor = .white
        caloriesPerDay.text = "Calories Per Day"
        caloriesPerDay.sizeToFit()

        caloriesPerDayNumber.center.x = view.center.x
        caloriesPerDay.center.x = view.center.x

        caloriesPerDay.center.y = lineBelowReccomendedWeight.frame.maxY + heightIndentForSections + (caloriesPerDay.bounds.height / 2.0)
        caloriesPerDayNumber.center.y = lineBelowTotalCalories.frame.minY - heightIndentForSections - (caloriesPerDayNumber.bounds.height / 2.0)

        let isPhoneSmall = UIScreen.main.bounds.width <= 320
        if isPhoneSmall {
            weightToLose.font = .systemFont(ofSize: 14)
            weightToLoseNumber.font = .boldSystemFont(ofSize: 16)
            weightToLosePerMonth.font = .systemFont(ofSize: 14)
            weightToLosePerMonthNumber.font = .boldSystemFont(ofSize: 16)
            caloriesPerDay.font = .systemFont(ofSize: 14)
            caloriesPerDayNumber.font = .boldSystemFont(ofSize: 16)

            weightToLose.sizeToFit()
            weightToLoseNumber.sizeToFit()
            weightToLosePerMonth.sizeToFit()
            weightToLosePerMonthNumber.sizeToFit()
            caloriesPerDay.sizeToFit()
            caloriesPerDayNumber.sizeToFit()

            weightToLose.center.x = view.center.x
            weightToLoseNumber.center.x = view.center.x
            weightToLosePerMonth.center.x = view.center.x
            weightToLosePerMonthNumber.center.x = view.center.x
            caloriesPerDay.center.x = view.center.x
            caloriesPerDayNumber.center.x = view.center.x

        }


        view.addSubview(weightToLose)
        view.addSubview(weightToLoseNumber)

        view.addSubview(weightToLosePerMonth)
        view.addSubview(weightToLosePerMonthNumber)

        view.addSubview(caloriesPerDay)
        view.addSubview(caloriesPerDayNumber)


    }


    func letsGoButtonClicked() {
        //FIREBASE: add created cat to firebase
        dismiss(animated: true, completion: nil)
    }
}


