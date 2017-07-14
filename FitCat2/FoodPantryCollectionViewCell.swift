//
//  FoodPantryCollectionViewCell.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/26/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class FoodPantryCollectionViewCell: UICollectionViewCell {
    var foodLabel: UILabel!
    var foodImageView: UIImageView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         let isPhoneSmall = UIScreen.main.bounds.width <= 320
        let foodLabelFrame = CGRect(x: self.bounds.width * 0.025, y: self.bounds.height * 0.70, width: self.bounds.width * 0.95, height: self.bounds.height * 0.40)
        foodLabel = UILabel(frame: foodLabelFrame)
        //foodLabel.center.x = self.center.x
        foodLabel.numberOfLines = 5
        foodLabel.font = isPhoneSmall ? UIFont.systemFont(ofSize: 9, weight: UIFontWeightMedium) : UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        foodLabel.textAlignment = .center
        
        contentView.addSubview(foodLabel)
        
        let foodImageViewFrame = CGRect(x: 5.0, y: 5.0, width: bounds.width - 10.0, height: bounds.height * 0.65)
        foodImageView = UIImageView(frame: foodImageViewFrame)
        foodImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(foodImageView)
    
    }
    
    func addImage(image: UIImage, isWet: Bool) {
        if isWet {
            foodImageView.frame = CGRect(x: bounds.width * 0.20, y: 5.0, width: bounds.width * 0.60, height: bounds.height * 0.50)
            foodImageView.center.x = bounds.width / 2.0
        } else {
            foodImageView.frame = CGRect(x: 5.0, y: 5.0, width: bounds.width - 10.0, height: bounds.height * 0.65)
        }
        foodImageView.image = image
    }
    
    func addLabel(text: String) {
        foodLabel.text = text
        foodLabel.sizeToFit()
        foodLabel.center.x = bounds.width / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
