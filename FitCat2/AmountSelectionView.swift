//
//  AmountSelectionView.swift
//  FitCat2
//
//  Created by Austin Astorga on 5/27/17.
//  Copyright © 2017 Ming Yang. All rights reserved.
//

import UIKit

class AmountSelectionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10.0
        backgroundColor = .white
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
