//
//  CatDetailTableViewCell.swift
//  FitCat2
//
//  Created by Austin Astorga on 4/7/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class CatDetailTableViewCell: UITableViewCell {

    let labelWidthConstant = CGFloat(45.0)
    let imageHeight = CGFloat(45.0)
    let imageWidth = CGFloat(45.0)
    let labelHeight = CGFloat(20.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x: 15, y: 5, width: imageWidth, height: imageHeight)
        imageView?.backgroundColor = .blue
        imageView?.contentMode = .scaleAspectFit
        imageView?.center.y = bounds.height / 2.0
        imageView?.layer.cornerRadius = 45.0/2.0
        imageView?.layer.masksToBounds = true
        //imageView?.image = #imageLiteral(resourceName: "EVO 95 Chicken and Turkey Recipe in Gravy Canned Cat Food")
        
        
    
        textLabel?.frame = CGRect(x: (imageView?.frame.maxX)! + 13.5, y: (imageView?.frame.minY)!, width: frame.width * 0.49, height: labelHeight)
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.numberOfLines = 0
        textLabel?.text = "Merrick Purrfect Bistro Grain Free Healthy Kitten Recipe Dry"
        textLabel?.sizeToFit()
        textLabel?.center.y = bounds.height / 2.0
        textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)

    
    }

}
