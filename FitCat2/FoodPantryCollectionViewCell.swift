//
//  FoodPantryCollectionViewCell.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/26/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class FoodPantryCollectionViewCell: UICollectionViewCell {
    var food: FoodModel? {
        didSet {
            if food != nil {
            foodLabel.text = food?.foodName
            if let imageURL = food?.image, let foodName = food?.foodName {
             addImage(url: imageURL, isWet: food?.style == "wet", foodName: foodName)
            }
            setupViews()
            }
        }
    }

    var foodLabel: UILabel = {
        let label = UILabel()
        let isPhoneSmall = UIScreen.main.bounds.width <= 320
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A random cat food that is totally delicious but isn't sold anywhere"
        label.textAlignment = .center
        let fontSize: CGFloat = isPhoneSmall ? 9.0 : 12.0
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightRegular)
        label.numberOfLines = 0
        return label
    }()

    var foodImageView: PantryImageView = {
        let imageView = PantryImageView()
        //imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func prepareForReuse() {
        // Remove any state in this cell that may be left over from its previous use.
        self.food = nil
        self.foodLabel.text = nil
        self.foodImageView.image = nil
    }

    func setupViews() {
        addSubview(foodLabel)
        addSubview(foodImageView)
        let imageHeight = food?.style == "wet" ? bounds.height * 0.40 : bounds.height * 0.60
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[v0]-15-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": foodImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": foodLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(imageHeight)]-3-[v1]-|", options: NSLayoutFormatOptions(), metrics: ["imageHeight": imageHeight], views: ["v0": foodImageView, "v1": foodLabel]))
    }

//    let isPhoneSmall = UIScreen.main.bounds.width <= 320
//    let foodLabelFrame = CGRect(x: self.bounds.width * 0.025, y: self.bounds.height * 0.70, width: self.bounds.width * 0.95, height: self.bounds.height * 0.40)
//    // foodLabel = UILabel(frame: foodLabelFrame)
//    // foodLabel.center.x = self.center.x
//    // foodLabel.numberOfLines = 5
//    foodLabel.font = isPhoneSmall ? UIFont.systemFont(ofSize: 9, weight: UIFontWeightMedium) : UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
//    foodLabel.textAlignment = .center
//
//    contentView.addSubview(foodLabel)
//
//    let foodImageViewFrame = CGRect(x: 5.0, y: 5.0, width: bounds.width - 10.0, height: bounds.height * 0.65)
//    foodImageView = PantryImageView(frame: foodImageViewFrame)
//    foodImageView.contentMode = .scaleAspectFit
//
//    contentView.addSubview(foodImageView)

    func addImage(url: String, isWet: Bool, foodName: String) {
        foodImageView.loadImagesUsingUrlString(urlString: url, isWet: isWet, foodName: foodName)
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
