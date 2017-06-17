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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let foodLabelFrame = CGRect(x: self.bounds.width * 0.05, y: self.bounds.height * 0.55, width: self.bounds.width * 0.90, height: self.bounds.height * 0.40)
        foodLabel = UILabel(frame: foodLabelFrame)
        //foodLabel.center.x = self.center.x
        foodLabel.numberOfLines = 4
        foodLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightSemibold)
        foodLabel.textAlignment = .center
        
        contentView.addSubview(foodLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
