//
//  AmountSelectionView.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/27/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

class AmountSelectionView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var amountOfCaloriesToFeed = 0.0
    var foodArray: [FoodModel] = []
    var longmarkerArray: [UIView] = []
    var selectedIndex: IndexPath!
    var currentCat: CreateCatModel!
    var timer: Timer?
    var dryFoodAmountSelection = [("1/4 Cup", 0.25), ("1/3 Cup", 0.33), ("1/2 Cup", 0.50), ("2/3 Cup", 0.66), ("3/4 Cup", 0.75), ("1 Cup", 1.0)]
    var wetFoodSmallSelection = [("1 oz", 0.33), ("1.5 oz", 0.50), ("2.0 oz", 0.66), ("2.5 oz", 0.83), ("3 oz", 1.0)]
    var wetFoodSmallCanEquivalent = ["1/3 Can", "1/2 Can", "2/3 Can", "2.5/3 Can", "1 Can"]
    var wetFoodLargeCanEquivalent = ["1/5.5 Can", "1.5/5.5 Can", "2/5.5 Can", "2.5/5.5 Can", "3/5.5 Can", "3.5/5.5 Can", "4/5.5 Can", "4.5/5.5 Can", "5/5.5 Can", "1 Can"]
    var wetFoodLargeSelection = [("1 oz", 0.1818181818), ("1.5 oz", 0.2727272727), ("2.0 oz", 0.3636363636), ("2.5 oz", 0.4545454545), ("3 oz", 0.5454545455), ("3.5 oz", 0.6363636364), ("4.0 oz", 0.7272727273), ("4.5 oz", 0.8181818182), ("5 oz", 0.9090909091), ("5.5 oz", 1.0)]

    let cancelButton = UIButton(type: .system)
    let changeWetFoodSizeButton = UIButton(type: .system)
    var catFoodImageView: UIImageView!
    let catFoodLabel = UILabel()
    var wetLabel: UIImageView!
    let calPerCanLabel = UILabel()
    let canSizeLabel = UILabel()
    let separatorView = UIView()
    var calLabel = UILabel()
    var calProgressBar: UIProgressView!
    let verticalSeperator = UIView()
    let ozLabel = UILabel()
    var ozProgressBar: UIProgressView!
    var cupLabel = UILabel()
    let logFeedingButton = UIButton()
    let amountTextField = UITextField()
    let amountPicker = UIPickerView()
    var wetFood = false
    var foodItem: FoodModel!
    var currentIndexOfCanSizeSelected = 0

    init(frame: CGRect, foodArray: [FoodModel], selectedIndex: IndexPath, currentCat: CreateCatModel, image: UIImage) {
        super.init(frame: frame)
        layer.cornerRadius = 10.0
        backgroundColor = .white
        clipsToBounds = true
        layer.masksToBounds = true
        foodItem = foodArray[selectedIndex.row]
        let isPhoneSmall = UIScreen.main.bounds.width <= 320
        //Cancel button
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.sizeToFit()
        addSubview(cancelButton)
        let x = NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cancelButton])

        self.addConstraints(x)
        //changeWetFoodSizeButton
        changeWetFoodSizeButton.setTitle("Change Can Size", for: .normal)
        changeWetFoodSizeButton.addTarget(self, action: #selector(changedWetFoodSizePressed), for: .touchUpInside)
        changeWetFoodSizeButton.sizeToFit()
        if let wetKcalPerCupArray = foodItem.wetKCalPerCup {
            if wetKcalPerCupArray.count > 1 {
                //addSubView(changeWetFoodSizeButton)
            }
        }
        //catfoodImage
        let photoWidthAndHeight: CGFloat = isPhoneSmall ? 0.20 : 0.35
        catFoodImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.height * photoWidthAndHeight, height: bounds.height * photoWidthAndHeight))
        catFoodImageView.image = image
        catFoodImageView.contentMode = .scaleAspectFit
        //addSubView(catFoodImageView)
        //catFoodLabel
        catFoodLabel.text = foodArray[selectedIndex.row].foodName
        catFoodLabel.font = UIFont.systemFont(ofSize: 19)
        catFoodLabel.numberOfLines = 0
        catFoodLabel.textAlignment = .center
        catFoodLabel.lineBreakMode = .byWordWrapping
        //addSubView(catFoodLabel)
        wetFood = foodItem.style == "wet"
        //wetLabel
        wetLabel = wetFood ? UIImageView(image: #imageLiteral(resourceName: "wetLabel")) : UIImageView(image: #imageLiteral(resourceName: "dryLabel"))
        //addSubView(wetLabel)
        //calPerCanLabel
        calPerCanLabel.text = wetFood ? "\((foodItem.wetKCalPerCup?[0]["kcalPerCup"])!) Cal/Can" : "\(foodItem.dryKCalPerCup!) Cal/Cup"
        calPerCanLabel.font = .systemFont(ofSize: 16, weight: UIFontWeightLight)
        calPerCanLabel.textAlignment = .center
        //addSubView(calPerCanLabel)
        //canSizeLabel
        canSizeLabel.text = wetFood ? "\((foodItem.wetKCalPerCup?[0]["canSize"])!) Cans" : ""
        canSizeLabel.font = .systemFont(ofSize: 16, weight: UIFontWeightLight)
        canSizeLabel.textAlignment = .center
        //addSubView(canSizeLabel)
        separatorView.pin.height(1)
        separatorView.backgroundColor = UIColor(white: 218.0 / 255.0, alpha: 1.0)
        //addSubView(separatorView)
        calLabel.text = "\(Int(currentCat.catFeeding.caloriesTotal - currentCat.catFeeding.caloriesToday)) Cals Remaining"
        calLabel.font = .systemFont(ofSize: 20, weight: UIFontWeightBold)
        calLabel.textAlignment = .center
        ozLabel.text = "2.5 oz"
        ozLabel.font = .systemFont(ofSize: 20, weight: UIFontWeightBold)
        ozLabel.textAlignment = .center
        ////addSubView(ozLabel)
        verticalSeperator.pin.height(32)
        verticalSeperator.pin.width(1)
        verticalSeperator.backgroundColor = UIColor(white: 218.0 / 255.0, alpha: 1.0)
        ////addSubView(verticalSeperator)
        //calProgressBar.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        calProgressBar = UIProgressView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width * 0.2685333333, height: 10.0))
        calProgressBar.transform = CGAffineTransform(scaleX: 1.0, y: 2.5)
        calProgressBar.layer.cornerRadius = 3.0
        calProgressBar.layer.masksToBounds = true
        calProgressBar.trackTintColor = .fitcatProgressGray
        calProgressBar.progress = currentCat.catFeeding.caloriesToday == 0.000000001 ? Float(0.0) : Float(currentCat.catFeeding.caloriesToday / currentCat.catFeeding.caloriesTotal)
        calProgressBar.progressTintColor = .fitcatProgressGreen
        calProgressBar.progress = Float(currentCat.catFeeding.caloriesToday / currentCat.catFeeding.caloriesTotal)
        let numberOfCalsRemaining = Int(currentCat.catFeeding.caloriesTotal - currentCat.catFeeding.caloriesToday)
        if numberOfCalsRemaining < 0 {
            calLabel.text = "\(abs(numberOfCalsRemaining)) Cals Over"
            calProgressBar.progressTintColor = .fitcatOrange
        } else {
            calLabel.text = "\(numberOfCalsRemaining) Cals Remaining"
            calProgressBar.progressTintColor = .fitcatProgressGreen
        }
        //addSubView(calLabel)
        //addSubView(calProgressBar)

        ozProgressBar = UIProgressView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width * 0.2685333333, height: 10.0))
        ozProgressBar.transform = CGAffineTransform(scaleX: 1.0, y: 20.0)
        ozProgressBar.layer.cornerRadius = 3.0
        ozProgressBar.layer.masksToBounds = true
        ozProgressBar.progressTintColor = .fitcatProgressGreen
        ozProgressBar.trackTintColor = .fitcatProgressGray
        ozProgressBar.progress = 0.0
        ////addSubView(ozProgressBar)

        amountTextField.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width * 0.50, height: 30.0)
        amountTextField.delegate = self
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: amountTextField.frame.size.height - width, width:  amountTextField.frame.size.width, height: amountTextField.frame.size.height)

        border.borderWidth = width
        amountTextField.layer.addSublayer(border)
        amountTextField.layer.masksToBounds = true
        amountTextField.textAlignment = .center
        amountTextField.placeholder = "Select Amount"
        //addSubView(amountTextField)

        amountTextField.inputView = amountPicker

        //picker
        amountPicker.delegate = self
        amountPicker.dataSource = self

        cupLabel.text = "2/3 Cups"
        cupLabel.font = .systemFont(ofSize: 20, weight: UIFontWeightLight)
        cupLabel.textAlignment = .center
        ////addSubView(cupLabel)

        logFeedingButton.backgroundColor = .fitcatOrange
        //logFeedingButton.layer.borderWidth = 2.0
        //logFeedingButton.layer.borderColor = UIColor.white.cgColor
        logFeedingButton.layer.cornerRadius = 7
        //logFeedingButton.setTitle("Feed \(cat.catName)", for: .normal)
        logFeedingButton.setTitle("Feed " + currentCat.catName, for: .normal)
        logFeedingButton.addTarget(self, action: #selector(logFeedingButtonClicked), for: .touchUpInside)
        //addSubView(logFeedingButton)

        if isPhoneSmall {
            cupLabel.font = .systemFont(ofSize: 16, weight: UIFontWeightLight)
            //ozLabel.font = .systemFont(ofSize: 16, weight: UIFontWeightBold)
            calLabel.font = .systemFont(ofSize: 16, weight: UIFontWeightBold)
            canSizeLabel.font = .systemFont(ofSize: 12, weight: UIFontWeightLight)
            calPerCanLabel.font = .systemFont(ofSize: 12, weight: UIFontWeightLight)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //603
//        let height = bounds.height
//        let width = bounds.width
//        cancelButton.pin.topLeft().margin(14.5, 22.5, 0.0, 0.0)
//        changeWetFoodSizeButton.pin.topRight().margin(14.5, 0.0, 0.0, 22.5)
//        catFoodImageView.pin.below(of: cancelButton).marginTop(height * 0.01913930348).hCenter()
//
//        catFoodLabel.pin.below(of: catFoodImageView, aligned: .center).width(self.bounds.width * 0.79).marginTop(height * 0.04676616915).sizeToFit().hCenter()
//
//        wetLabel.pin.below(of: catFoodLabel).marginLeft(width * 0.108).left().marginTop(height * 0.0447761194)
//
//        canSizeLabel.pin.below(of: catFoodLabel, aligned: .center).width(
//            self.bounds.width * 0.20).marginTop(height * 0.0447761194).sizeToFit()
//
//        calPerCanLabel.pin.below(of: catFoodLabel).width( self.bounds.width * 0.236).right().marginRight(width * 0.108).marginTop(height * 0.0447761194).sizeToFit()
//
//        separatorView.pin.below(of: canSizeLabel, aligned: .center).width(self.bounds.width).marginTop(height * 0.04975124378)
//
//        //verticalSeperator.pin.below(of: separatorView, aligned: .center).marginTop(height * 0.05721393035)
//        calLabel.pin.below(of: separatorView, aligned: .center).width(self.bounds.width * 0.8).marginTop(height * 0.04228855721).sizeToFit()
//
//        //ozLabel.pin.below(of: separatorView).width(self.bounds.width * 0.228).marginTop(height 0.04228855721).right(of: verticalSeperator).marginLeft(47.0).sizeToFit()
//
//        calProgressBar.pin.below(of: calLabel, aligned: .center).marginTop(height * 0.02072968491)
//            //ozProgressBar.pin.below(of: ozLabel, aligned: .center).marginTop(height * 0.02072968491 )
//
//            amountTextField.pin.below(of: calProgressBar).marginTop(30).hCenter()
//
//            //cupLabel.pin.below(of: ozProgressBar, aligned: .center).width(self.bounds.width  .2386666667).marginTop(5.0).sizeToFit()
//
//            logFeedingButton.pin.bottom().width(bounds.width * 0.828).height(height * 0.0912106136).marginBottom(21.5).hCenter()
    }

    func logFeedingButtonClicked() {
        print(amountOfCaloriesToFeed)
        currentCat.catFeeding.caloriesToday += amountOfCaloriesToFeed
        //update currentCat
        if let user = FIRAuth.auth()?.currentUser {
            let newCatRef = firebaseRef.child("users").child(user.uid).child("catCollection").child(currentCat.firebaseID!).child("catFeeding")
            if let foodHistory = currentCat.catFeeding.foodHistory {
                print(foodHistory)
                print("adding food entry")
                var foodHistoryUpdated = foodHistory
                foodHistoryUpdated[newCatRef.childByAutoId().key] = ["name": foodItem.foodName, "amount": Int(amountOfCaloriesToFeed)]
                newCatRef.updateChildValues(["caloriesToday": currentCat.catFeeding.caloriesToday, "currentDate": "\(currentCat.catFeeding.currentDate)", "foodHistory": foodHistoryUpdated])
                currentCat.catFeeding.foodHistory = foodHistoryUpdated
            } else {

                newCatRef.updateChildValues(["caloriesToday": currentCat.catFeeding.caloriesToday, "currentDate": "\(currentCat.catFeeding.currentDate)", "foodHistory": [newCatRef.childByAutoId().key: ["name": foodItem.foodName, "amount": Int(amountOfCaloriesToFeed)]]])
                currentCat.catFeeding.foodHistory = [newCatRef.childByAutoId().key: ["name": foodItem.foodName, "amount": Int(amountOfCaloriesToFeed)]]
            }
        } else {
            print("Couldnt update user")
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = UIScreen.main.bounds.maxY + 5.0
        }) { _ in
            self.removeFromSuperview()
        }
    }

    func cancelButtonPressed() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = UIScreen.main.bounds.maxY + 5.0
        }) { _ in
            self.removeFromSuperview()
        }
    }

    func changedWetFoodSizePressed() {
        currentIndexOfCanSizeSelected = currentIndexOfCanSizeSelected == 0 ? 1 : 0
        calPerCanLabel.text = "\((foodItem.wetKCalPerCup?[currentIndexOfCanSizeSelected]["kcalPerCup"])!) Cal/Can"
        canSizeLabel.text = "\((foodItem.wetKCalPerCup?[currentIndexOfCanSizeSelected]["canSize"])!) Cans"
        canSizeLabel.sizeToFit()
        layoutSubviews()
        amountPicker.reloadAllComponents()

    }

    func updateCaloriesRemaining(amountOfCalories: Double) {
        calProgressBar.progress = Float((currentCat.catFeeding.caloriesToday + amountOfCalories) / currentCat.catFeeding.caloriesTotal)
        let numberOfCalsRemaining = Int(currentCat.catFeeding.caloriesTotal - currentCat.catFeeding.caloriesToday - amountOfCalories)
        if numberOfCalsRemaining < 0 {
            calLabel.text = "\(abs(numberOfCalsRemaining)) Cals Over"
            calProgressBar.progressTintColor = .fitcatOrange
        } else {
            calLabel.text = "\(numberOfCalsRemaining) Cals Remaining"
            calProgressBar.progressTintColor = .fitcatProgressGreen

        }
        amountOfCaloriesToFeed = amountOfCalories
        layoutSubviews()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            switch foodItem.style {
            case "wet":
                switch currentIndexOfCanSizeSelected {
                case 0:
                    amountTextField.placeholder = wetFoodSmallCanEquivalent[0]
                    amountTextField.text = wetFoodSmallSelection[0].0
                    let amountOfCaloriesSelected = wetFoodLargeSelection[0].1 * Double((foodItem.wetKCalPerCup?[currentIndexOfCanSizeSelected]["kcalPerCup"])!)!
                    updateCaloriesRemaining(amountOfCalories: amountOfCaloriesSelected)

                case 1:
                    amountTextField.placeholder = wetFoodLargeCanEquivalent[0]
                    amountTextField.text = wetFoodLargeSelection[0].0
                    let kcalPerCup = foodItem.wetKCalPerCup?[currentIndexOfCanSizeSelected]["kcalPerCup"]?.trimmingCharacters(in: .whitespacesAndNewlines)

                    let amountOfCaloriesSelected = wetFoodLargeSelection[0].1 * Double(kcalPerCup!)!
                    updateCaloriesRemaining(amountOfCalories: amountOfCaloriesSelected)

                default:
                    break
                }

            case "dry":
                amountTextField.text = dryFoodAmountSelection[0].0
                let amountOfCaloriesSelected = dryFoodAmountSelection[0].1 * Double(foodItem.dryKCalPerCup!)
                updateCaloriesRemaining(amountOfCalories: amountOfCaloriesSelected)
            default:
                print("uh oh")
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch foodItem.style {
        case "wet":
            switch currentIndexOfCanSizeSelected {
            case 0:
                amountTextField.placeholder = wetFoodSmallCanEquivalent[row]
                amountTextField.text = wetFoodSmallSelection[row].0
                let amountOfCaloriesSelected = wetFoodLargeSelection[row].1 * Double((foodItem.wetKCalPerCup?[currentIndexOfCanSizeSelected]["kcalPerCup"])!)!
                updateCaloriesRemaining(amountOfCalories: amountOfCaloriesSelected)

            case 1:
                amountTextField.placeholder = wetFoodLargeCanEquivalent[row]
                amountTextField.text = wetFoodLargeSelection[row].0
                let kcalPerCup = foodItem.wetKCalPerCup?[currentIndexOfCanSizeSelected]["kcalPerCup"]?.trimmingCharacters(in: .whitespacesAndNewlines)
                let amountOfCaloriesSelected = wetFoodLargeSelection[row].1 * Double(kcalPerCup!)!
                updateCaloriesRemaining(amountOfCalories: amountOfCaloriesSelected)

            default:
                break
            }

        case "dry":
            amountTextField.placeholder = dryFoodAmountSelection[row].0
            amountTextField.text = dryFoodAmountSelection[row].0
            let amountOfCaloriesSelected = dryFoodAmountSelection[row].1 * Double(foodItem.dryKCalPerCup!)
            updateCaloriesRemaining(amountOfCalories: amountOfCaloriesSelected)
        default:
            print("Food not wet or dry??")
        }
        IQKeyboardManager.sharedManager().reloadInputViews()
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return wetFood ? currentIndexOfCanSizeSelected == 0 ? wetFoodSmallSelection.count : wetFoodLargeSelection.count : dryFoodAmountSelection.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return wetFood ? currentIndexOfCanSizeSelected == 0 ? wetFoodSmallSelection[row].0 : wetFoodLargeSelection[row].0 : dryFoodAmountSelection[row].0
    }
}
