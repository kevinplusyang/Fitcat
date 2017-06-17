//
//  WeightPicker.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/21/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

class WeightPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var isPounds = true
    let pounds = [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
    let ounces = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    let kilograms = [2,3,4,5,6,7,8,9,10,11,12]
    let grams = [".0",".1",".2",".3",".4",".5",".6",".7",".8",".9"]
    var poundsString = "3 Pounds"
    var ouncesString = " 0 Ounces"
    var kilogramsString = "2"
    var gramsString = ".0 Kilograms"
    var catViewController : CreateCatViewController? = nil

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
        return isPounds ? 4 : 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isPounds {
            if component % 2 != 0 {
                return 1
            } else {
             return component == 0 ? pounds.count : ounces.count
            }
        } else {
            if component == 2 {
                return 1
            } else {
              return component == 0 ? kilograms.count : grams.count
            }
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isPounds {
            if component % 2 != 0 {
                return component == 1 ? "Pounds" : "Ounces"
            } else {
                return component == 0 ? String(pounds[row]) : String(ounces[row])
            }
        } else {
            if component == 2 {
                return "Kilograms"
            } else {
                return component == 0 ? String(kilograms[row]) : String(grams[row])
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isPounds {
            if component == 0 {
                poundsString = "\(pounds[row]) Pounds"
            } else {
                ouncesString = ounces[row] == 1 ? " \(ounces[row]) Ounce" : " \(ounces[row]) Ounces"
            }
        } else {
            if component == 0 {
                kilogramsString = "\(kilograms[row])"
            } else {
               gramsString = "\(grams[row]) Kilograms"
            }
        }
        catViewController?.updateWeightDisplay()

       
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if isPounds {
            if component % 2 != 0 {
                return 100.0
            } else {
                return 38.0
            }
        } else {
                return component == 2 ? 140.0 : 38.0
            
        }
    }
}
