//
//  WeightPicker.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/21/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

class WeightPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pounds = ["1 Pound","2 Pounds","3 Pounds","4 Pounds","5 Pounds","6 Pounds","7 Pounds","8 Pounds","9 Pounds","10 Pounds"]
    let ounces = ["1 Ounce","2 Ounces","3 Ounces","4 Ounces","5 Ounces","6 Ounces","7 Ounces","8 Ounces","9 Ounces","10 Ounces", "11 Ounces", "12 Ounces", "13 Ounces", "14 Ounces", "15 Ounces", "16 Ounces"]
    var selectedPounds = ""
    var selectedOunces = ""

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        delegate = self
        dataSource = self
    }
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? pounds.count : ounces.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? pounds[row] : ounces[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedPounds = pounds[row]
        } else {
            selectedOunces = ounces[row]
        }
    }

}
