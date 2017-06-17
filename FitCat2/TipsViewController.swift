//
//  TipsViewController.swift
//  FitCat2
//
//  Created by Austin Astorga on 3/14/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    
    let tipsForSuccessLabel = UILabel()
    let gotItButton = UIButton()
    let tipOneTextView = UILabel()
    let tipTwoTextView = UILabel()
    let tipThreeTextView = UILabel()
    let tipFourTextView = UILabel()
    let stackView = UIStackView()
    let tipOneCircle = CALayer()
    let tipOneLine = CALayer()
    let tipTwoCircle = CALayer()
    let tipTwoLine = CALayer()
    let tipThreeCircle = CALayer()
    let tipThreeLine = CALayer()
    let tipFourCircle = CALayer()
    let tipFourLine = CALayer()
    var count = 0
    
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
        navigationController?.navigationBar.barTintColor = UIColor(red: 93/255, green: 92/255, blue: 92/255, alpha: 1.0)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 93/255, green: 92/255, blue: 92/255, alpha: 1.0)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 93/255, green: 92/255, blue: 92/255, alpha: 1.0)
        
        //Got it Button
        let buttonWidth = view.frame.width * 0.828
        let buttonHeight = 55.0
        gotItButton.frame = CGRect(x: CGFloat(0), y: view.frame.height - 85.0, width: buttonWidth, height: CGFloat(buttonHeight))
        gotItButton.center.x = view.center.x
        gotItButton.layer.borderWidth = 2.0
        gotItButton.layer.borderColor = UIColor.white.cgColor
        gotItButton.layer.cornerRadius = 7
        gotItButton.setTitle("Got it!", for: .normal)
        gotItButton.addTarget(self, action: #selector(gotItButtonPressed), for: .touchUpInside)
        view.addSubview(gotItButton)
        
        //Text Views
        tipOneTextView.textColor = .white
        tipOneTextView.numberOfLines = 6
        tipOneTextView.text = "Please assure that your cat is receiving only the food being tracked by FitCat"
        tipOneTextView.sizeToFit()
        
        tipTwoTextView.textColor = view.backgroundColor
        tipTwoTextView.numberOfLines = 6
        tipTwoTextView.text = "Any addiontal treats, human food, or the food of other cats/dogs in the household will make the weight loss less likely."
        tipTwoTextView.sizeToFit()
        
        tipThreeTextView.textColor = view.backgroundColor
        tipThreeTextView.numberOfLines = 6
        tipThreeTextView.text = "The recommended amount of food should be provided at specific times of the day, and no food should be made available between these feeding times."
        tipThreeTextView.sizeToFit()
        
        tipFourTextView.textColor = view.backgroundColor
        tipFourTextView.numberOfLines = 6
        tipFourTextView.text = "Careful measuring of food is essential for success."
        tipFourTextView.sizeToFit()
        
        let isPhoneSmall = UIScreen.main.bounds.width <= 320
        if isPhoneSmall {
        tipOneTextView.font = UIFont.systemFont(ofSize: 13)
        tipTwoTextView.font = UIFont.systemFont(ofSize: 13)
        tipThreeTextView.font = UIFont.systemFont(ofSize: 13)
        tipFourTextView.font = UIFont.systemFont(ofSize: 13)
        }
        //Tips Label
        tipsForSuccessLabel.textColor = .white
        tipsForSuccessLabel.font = UIFont.boldSystemFont(ofSize: 18)
        tipsForSuccessLabel.text = "Tips For Success"
        tipsForSuccessLabel.sizeToFit()
        tipsForSuccessLabel.center.x = view.center.x
        tipsForSuccessLabel.center.y = (navigationController?.navigationBar.bounds.height)! + 15.0 + tipsForSuccessLabel.bounds.height
        view.addSubview(tipsForSuccessLabel)
        
        stackView.frame = CGRect(x: view.bounds.width * 0.20, y: tipsForSuccessLabel.frame.maxY + 30, width: view.bounds.width * 0.60, height: gotItButton.frame.minY - tipsForSuccessLabel.frame.maxY - 60)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5
        
        stackView.addArrangedSubview(tipOneTextView)
        stackView.addArrangedSubview(tipTwoTextView)
        stackView.addArrangedSubview(tipThreeTextView)
        stackView.addArrangedSubview(tipFourTextView)
        
        view.addSubview(stackView)
        
        let tipOneFrame = stackView.convert(tipOneTextView.frame, to: view)
        tipOneCircle.frame = CGRect(x: tipOneFrame.minX - 30.0, y: tipOneFrame.minY + 3.0, width: 15.0, height: 15.0)
        tipOneCircle.backgroundColor = UIColor(red: 15.0 / 255.0, green: 200.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0).cgColor
        tipOneCircle.borderWidth = 3.0
        tipOneCircle.cornerRadius = 15.0 / 2.0
        tipOneCircle.borderColor = UIColor.white.cgColor
        view.layer.addSublayer(tipOneCircle)
        
    }
    
    func gotItButtonPressed(sender: UIButton) {
        count += 1
        if count == 1 {
            tipOneTextView.alpha = 0.4
            tipTwoTextView.textColor = .white
            
            let tipTwoFrame = stackView.convert(tipTwoTextView.frame, to: view)
            tipTwoCircle.frame = CGRect(x: tipOneCircle.frame.minX, y: tipTwoFrame.minY + 3.0, width: 15.0, height: 15.0)
            tipTwoCircle.backgroundColor = UIColor(red: 15.0 / 255.0, green: 200.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0).cgColor
            tipTwoCircle.borderWidth = 3.0
            tipTwoCircle.cornerRadius = 15.0 / 2.0
            tipTwoCircle.borderColor = UIColor.white.cgColor
            view.layer.addSublayer(tipTwoCircle)
            
            tipOneLine.frame = CGRect(x: tipTwoCircle.frame.midX - 0.5, y: tipOneCircle.frame.maxY + 3.0, width: 1.0, height: tipTwoCircle.frame.minY - 3.0 - (tipOneCircle.frame.maxY + 3.0))
            tipOneLine.backgroundColor = UIColor.white.cgColor
            view.layer.addSublayer(tipOneLine)
        }
            
        else if count == 2 {
            tipTwoTextView.alpha = 0.4
            tipThreeTextView.textColor = .white
            let tipThreeFrame = view.convert(tipThreeTextView.frame, from: stackView)
            tipThreeCircle.frame = CGRect(x: tipOneCircle.frame.minX, y: tipThreeFrame.minY + 3.0, width: 15.0, height: 15.0)
            tipThreeCircle.backgroundColor = UIColor(red: 15.0 / 255.0, green: 200.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0).cgColor
            tipThreeCircle.borderWidth = 3.0
            tipThreeCircle.cornerRadius = 15.0 / 2.0
            tipThreeCircle.borderColor = UIColor.white.cgColor
            view.layer.addSublayer(tipThreeCircle)
            
            tipTwoLine.frame = CGRect(x: tipTwoCircle.frame.midX - 0.5, y: tipTwoCircle.frame.maxY + 3.0, width: 1.0, height: tipThreeCircle.frame.minY - 3.0 - (tipTwoCircle.frame.maxY + 3.0))
            tipTwoLine.backgroundColor = UIColor.white.cgColor
            view.layer.addSublayer(tipTwoLine)
        }
            
        else if count == 3 {
            tipThreeTextView.alpha = 0.4
            tipFourTextView.textColor = .white
            let tipFourFrame = view.convert(tipFourTextView.frame, from: stackView)
            tipFourCircle.frame = CGRect(x: tipOneCircle.frame.minX, y: tipFourFrame.minY + 3.0, width: 15.0, height: 15.0)
            tipFourCircle.backgroundColor = UIColor(red: 15.0 / 255.0, green: 200.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0).cgColor
            tipFourCircle.borderWidth = 3.0
            tipFourCircle.cornerRadius = 15.0 / 2.0
            tipFourCircle.borderColor = UIColor.white.cgColor
            view.layer.addSublayer(tipFourCircle)
            
            tipThreeLine.frame = CGRect(x: tipTwoCircle.frame.midX - 0.5, y: tipThreeCircle.frame.maxY + 3.0, width: 1.0, height: tipFourCircle.frame.minY - 3.0 - (tipThreeCircle.frame.maxY + 3.0))
            tipThreeLine.backgroundColor = UIColor.white.cgColor
            view.layer.addSublayer(tipThreeLine)
        }
            
        else {
            let measurementVC = MeasurementViewController()
            measurementVC.catName = catName
            measurementVC.catBCS = catBCS
            measurementVC.catBirthday = catBirthday
            measurementVC.catBreed = catBreed
            measurementVC.catWeight = catWeight
            measurementVC.catNeutered = catNeutered
            measurementVC.catGender = catGender
            measurementVC.catImageData = catImageData
            navigationController?.pushViewController(measurementVC, animated: true)
        }
    }  
}
