//
//  MeasurementViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 2/28/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class MeasurementViewController: UIViewController {
    
    let generatePlanButton = UIButton()
    let measurementLabel = UILabel()
    let foodScaleLabel = UILabel()
    let measuringCupLabel = UILabel()
    
    //New Cat Parameters
    var catImageData: Data?
    var catName: String?
    var catBirthday: Date?
    var catBreed: String?
    var catWeight: Double?
    var catNeutered: Int? //0 is False, 1 is True
    var catGender: Int = 1 //1 is male, 2 is female
    var catBCS: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = UIColor(red: 93/255, green: 92/255, blue: 92/255, alpha: 1.0)
        
        
        //Continue Button
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        generatePlanButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        generatePlanButton.center.x = view.center.x
        generatePlanButton.layer.borderWidth = 2.0
        generatePlanButton.layer.borderColor = UIColor.white.cgColor
        generatePlanButton.layer.cornerRadius = 7
        generatePlanButton.setTitle("Generate Plan", for: .normal)
        generatePlanButton.addTarget(self, action: #selector(generatePlan), for: .touchUpInside)
        view.addSubview(generatePlanButton)
        
        //Measurement
        measurementLabel.textColor = .white
        measurementLabel.font = UIFont.boldSystemFont(ofSize: 18)
        measurementLabel.text = "Measurement"
        measurementLabel.sizeToFit()
        measurementLabel.center.x = view.center.x
        measurementLabel.center.y = (navigationController?.navigationBar.bounds.height)! + 15.0 + measurementLabel.bounds.height
        view.addSubview(measurementLabel)
        
        
        //measuringCupLabel
        //start 18% in
        //measuringCupLabel.frame = CGRect(x: view.bounds.width * 0.20, y: generatePlanButton.frame.minY - 100 - 30, width: view.bounds.width * 0.60, height: 90.0)
        
        let scaleImageView = UIImageView(image: UIImage(named: "measurement1"))
        let eightOuncesImageView = UIImageView(image: UIImage(named: "measurement2"))
        //measurementLink
        let measurementLinkImageView = UIImageView(image: UIImage(named: "measurementLink"))
        foodScaleLabel.textColor = .white
        foodScaleLabel.numberOfLines = 3
        foodScaleLabel.text = "A food scale can be used to measure out wet food."
        foodScaleLabel.textAlignment = .center
        foodScaleLabel.sizeToFit()
        
        measuringCupLabel.textColor = .white
        measuringCupLabel.numberOfLines = 3
        measuringCupLabel.text = "A measuring cup can be used for dry food. 1 Cup equals 8 Ounces."
        measuringCupLabel.textAlignment = .center
        measuringCupLabel.sizeToFit()

        let isPhoneSmall = UIScreen.main.bounds.width <= 320
        if isPhoneSmall {
            foodScaleLabel.font = .systemFont(ofSize: 14)
            measuringCupLabel.font = .systemFont(ofSize: 14)
        }

        let stackView = UIStackView()
        stackView.frame = CGRect(x: view.bounds.width * 0.20, y: measurementLabel.frame.maxY + 30, width: view.bounds.width * 0.60, height: generatePlanButton.frame.minY - measurementLabel.frame.maxY - 60)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.addArrangedSubview(scaleImageView)
        stackView.addArrangedSubview(foodScaleLabel)
        stackView.addArrangedSubview(measurementLinkImageView)
        stackView.addArrangedSubview(eightOuncesImageView)
        stackView.addArrangedSubview(measuringCupLabel)
        view.addSubview(stackView)
        
        measurementLinkImageView.isHidden = true
        
        measurementLinkImageView.isHidden = false
    
        
    }
    
    
    func generatePlan() {
        //MARK: vvvvv target weight. final weight
        guard let catBCS = catBCS, let catWeight = catWeight else {
            //MARK: Error handling. What happens if these are nil???
            return
        }
        
        let weightNeedToLoss = Double(catBCS  - 5) * 0.075 * catWeight
        let monthNeeded = Double(catBCS - 5) * 7.5
        let weightLossPerMonth = weightNeedToLoss / monthNeeded
        let end_weight = catWeight - weightNeedToLoss
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        
        let monthNeededInt = Int(monthNeeded)
        let monthRestDouble = monthNeeded - Double(Int(monthNeeded))
        
        let startDate = dateFormatter.string(from: Date())
        let trimmedStartDate = dateFormatter.date(from: startDate)
        
        let planStartDate = trimmedStartDate!
        var planEndDate = Calendar.current.date(byAdding: .month, value: monthNeededInt, to: trimmedStartDate!)
        
        let interval = TimeInterval(60 * 60 * 24 * 30 * monthRestDouble)
        planEndDate = planEndDate?.addingTimeInterval(interval)
        
        let catTotalWeightLoss = weightNeedToLoss
        let catWeightLossPerMonth = weightLossPerMonth
        let catCalories = 0.8 * (30 * catWeight + 70)
        
        
        
        
       
        let catPlan = PlanModel(planStartDate: planStartDate, planEndDate: planEndDate!, catTotalWeightLoss: catTotalWeightLoss, catWeightLossPerMonth: catWeightLossPerMonth, catCalories: catCalories)
        
        let catFoodModel = CatFeedingModel(caloriesTotal: catCalories, caloriesToday: 0.000000001, goalWeight: end_weight, currentWeight: catWeight, goalBcs: 5, weightLost: 0.000000001, currentDate: Date(), foodHistory: nil)
        
        guard let catName = catName, let catBirthdayField = catBirthday, let catBreedField = catBreed, let catNeuteredField = catNeutered, let catPictureData = catImageData
            else { return }
        
        let newCatObject = CreateCatModel(catName: catName, catBirthday: catBirthdayField, catBreed: catBreedField, catInitialWeight: catWeight, catNeutered: catNeuteredField, catGender: catGender, catInitialBCS: catBCS, catPictureData: catPictureData, catPlan: catPlan, catFeeding: catFoodModel, firebaseID: nil)
        
        updateUser(parameters: prepareNewCatParameters(cat: newCatObject))
        
        let dest = PlanOverviewControllerViewController()
        dest.cat = newCatObject
        navigationController?.pushViewController(dest, animated: true)
    }
    


}
