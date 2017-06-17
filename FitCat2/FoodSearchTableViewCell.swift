//
//  FoodSearchTableViewCell.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/25/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class FoodSearchTableViewCell: UITableViewCell {

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

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.numberOfLines = 3
        textLabel?.frame = CGRect(x: 15.0, y: 0.0, width: frame.width * 0.80, height: frame.height * 0.70)
        textLabel?.center.y = bounds.height / 2.0
        textLabel?.font = .systemFont(ofSize: 14)
    }

}
