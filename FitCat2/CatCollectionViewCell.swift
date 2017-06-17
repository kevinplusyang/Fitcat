//
//  CatCollectionViewCell.swift
//  FitCat2
//
//  Created by Austin Astorga on 4/3/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    var catImageView: UIImageView!
    var catName: UILabel!
    var calorieView: UIView!
    var intakeCaloriesLabel: UILabel!
    var intakeCaloriesNumberLabel: UILabel!
    var caloriesRemainingLabel: UILabel!
    var caloriesRemainingNumberLabel: UILabel!
    var calorieProgressBar: UIProgressView!
    var calorieCircleProgress: KDCircularProgress!
    var calorieCircleProgressPercent: UILabel!
    var logAFeeding: UIButton!
    var logAWeight: UIButton!
    var buttonStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         calorieView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height * 0.55))
        calorieView.backgroundColor = UIColor(white: 244.0 / 255.0, alpha: 1.0)
        calorieView.center.y = contentView.center.y
        contentView.addSubview(calorieView)
        
        catImageView = UIImageView(frame: CGRect(x: 14.0, y: 0.0, width: 38.0, height: 38.0))
        catImageView.layer.cornerRadius = catImageView.bounds.height / 2.0
        catImageView.layer.masksToBounds = true
        catImageView.center.y = calorieView.frame.minY / 2.0
        contentView.addSubview(catImageView)
        
        catName = UILabel(frame: CGRect(x: catImageView.frame.maxX + 17.0, y: 0.0, width: 50.0, height: 20.0))
        catName.textColor = .fitcatLightGrayText
        catName.font = UIFont.boldSystemFont(ofSize: 16)
        catName.center.y = calorieView.frame.minY / 2.0
        contentView.addSubview(catName)
        
        calorieCircleProgress = KDCircularProgress(frame: CGRect(x: frame.size.width - 60.0, y: 0.0, width: 45.0, height: 45.0))
        calorieCircleProgress.center.y = calorieView.frame.minY / 2.0
        calorieCircleProgress.startAngle = -90.0
        calorieCircleProgress.progressThickness = 0.15
        calorieCircleProgress.trackThickness = 0.2
        calorieCircleProgress.clockwise = true
        calorieCircleProgress.set(colors: .fitcatProgressGreen)
        calorieCircleProgress.trackColor = .fitcatProgressGray
        calorieCircleProgress.progress = 0.31
        contentView.addSubview(calorieCircleProgress)
        
        calorieCircleProgressPercent = UILabel()
        calorieCircleProgressPercent.font = .systemFont(ofSize: 12)
        calorieCircleProgressPercent.textColor = .fitcatLightGrayText
        calorieCircleProgressPercent.text = "\(Int(calorieCircleProgress.progress * 100.0))%"
        calorieCircleProgressPercent.sizeToFit()
        calorieCircleProgressPercent.center = calorieCircleProgress.center
        contentView.addSubview(calorieCircleProgressPercent)
        
        logAFeeding = UIButton()
        logAWeight = UIButton()
        
        logAFeeding.setImage(#imageLiteral(resourceName: "feedIcon"), for: .normal)
        logAWeight.setImage(#imageLiteral(resourceName: "design24PxOutlineDesign"), for: .normal)
        
        logAFeeding.setTitle("Log a feeding", for: .normal)
        logAWeight.setTitle("Log a weight", for: .normal)
        
        logAFeeding.setTitleColor(.fitcatLightGrayText, for: .normal)
        logAWeight.setTitleColor(.fitcatLightGrayText, for: .normal)
        
        logAFeeding.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        logAWeight.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        logAFeeding.sizeToFit()
        logAWeight.sizeToFit()
        
        let width = UIScreen.main.bounds.width <= 320 ? frame.size.width * 0.85 : frame.size.width * 0.70
        buttonStackView = UIStackView(frame: CGRect(x: 0.0, y: calorieView.frame.maxY, width: width, height: frame.size.height - calorieView.frame.maxY))
        buttonStackView.center.x = contentView.center.x
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalSpacing
        buttonStackView.alignment = .center
        buttonStackView.spacing = 5
        buttonStackView.addArrangedSubview(logAFeeding)
        buttonStackView.addArrangedSubview(logAWeight)
        buttonStackView.layoutIfNeeded()
        contentView.addSubview(buttonStackView)
        
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
        
        let intakeCaloriesParentFrame = contentView.convert(buttonStackView.arrangedSubviews[0].center, from: buttonStackView)
        let caloriesRemainingParentFrame = contentView.convert(buttonStackView.arrangedSubviews[1].center, from: buttonStackView)
        
        intakeCaloriesLabel.center.x = intakeCaloriesParentFrame.x
        caloriesRemainingLabel.center.x = caloriesRemainingParentFrame.x
        
        intakeCaloriesLabel.center.y = calorieView.bounds.height * 0.2
        caloriesRemainingLabel.center.y = calorieView.bounds.height * 0.2
        
        calorieView.addSubview(intakeCaloriesLabel)
        calorieView.addSubview(caloriesRemainingLabel)
        
        intakeCaloriesNumberLabel = UILabel()
        caloriesRemainingNumberLabel = UILabel()
        
        intakeCaloriesNumberLabel.textColor = .fitcatLightGrayText
        caloriesRemainingNumberLabel.textColor = .fitcatLightGrayText
        
        intakeCaloriesNumberLabel.font = .boldSystemFont(ofSize: 20)
        caloriesRemainingNumberLabel.font = .boldSystemFont(ofSize: 20)
        
        intakeCaloriesNumberLabel.sizeToFit()
        caloriesRemainingNumberLabel.sizeToFit()
        
        intakeCaloriesNumberLabel.center.y = calorieView.center.y
        caloriesRemainingNumberLabel.center.y = calorieView.center.y
        
        intakeCaloriesNumberLabel.center.x = intakeCaloriesLabel.center.x
        caloriesRemainingNumberLabel.center.x = caloriesRemainingLabel.center.x
        
        contentView.addSubview(intakeCaloriesNumberLabel)
        contentView.addSubview(caloriesRemainingNumberLabel)
        
        calorieProgressBar = UIProgressView(frame: CGRect(x: 0.0, y: 0.0, width: buttonStackView.bounds.width, height: 14.0))
        calorieProgressBar.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        calorieProgressBar.layer.cornerRadius = 3.0
        calorieProgressBar.layer.masksToBounds = true
        calorieProgressBar.progressTintColor = .fitcatProgressGreen
        calorieProgressBar.trackTintColor = .fitcatProgressGray
        calorieProgressBar.progress = Float(calorieCircleProgress.progress)
        calorieProgressBar.center.x = contentView.center.x
        calorieProgressBar.center.y = calorieView.frame.maxY - (intakeCaloriesLabel.center.y)
        contentView.addSubview(calorieProgressBar)
        

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func centerLabels() {
        
        intakeCaloriesNumberLabel.sizeToFit()
        caloriesRemainingNumberLabel.sizeToFit()
        calorieCircleProgressPercent.sizeToFit()
        intakeCaloriesNumberLabel.center.y = calorieView.center.y
        caloriesRemainingNumberLabel.center.y = calorieView.center.y
        
        intakeCaloriesNumberLabel.center.x = intakeCaloriesLabel.center.x
        caloriesRemainingNumberLabel.center.x = caloriesRemainingLabel.center.x
        
        calorieCircleProgressPercent.center = calorieCircleProgress.center

    }
    
    
    
    
}
