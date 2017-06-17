//
//  Extensions.swift
//  FitCat2
//
//  Created by Austin Astorga on 12/24/16.
//  Copyright © 2016 Ming Yang. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

class InsetLabel: UILabel
{
    let topInset = CGFloat(0)
    let bottomInset = CGFloat(0)
    let leftInset = CGFloat(8)
    let rightInset = CGFloat(8)
    
    override func drawText(in rect: CGRect)
    {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize
    {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}

extension String {

    public func firstIndex(of string: String) -> Int? {
        return Array(self.characters).map({String($0)}).index(of: string)
    }
    
    func getPounds() -> String {
        let intOfSpace = self.firstIndex(of: " ")!
        let index = self.index(self.startIndex, offsetBy: intOfSpace)
        return self.substring(to: index)
    }
    
    
    func getOunces() -> String{
        let intofS = self.firstIndex(of: "s")! + 1
        let index = self.index(self.startIndex, offsetBy: intofS)
        let endIndex = self.index(index, offsetBy: 2)
        let ounces = self[index...endIndex]
        return ounces.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}


extension Double {
    func poundsToOunces() -> Double {
        return self * 16.0
    }
    
    func ouncesToKilograms() -> Double {
        return self/35.27396195
    }
    
    func kilogramsToPounds() -> Double {
        return self * 2.2046226218
    }
    
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func trim2Decimals() -> Double {
        let divisor = pow(10.0, 2.0)
        return (self * divisor).rounded() / divisor
    }
}

extension UIColor {
    class var fitcatGray: UIColor {
        return UIColor(red: 75.0 / 255.0, green: 74.0 / 255.0, blue: 74.0 / 255.0, alpha: 1.0)
    }
    
    class var fitcatLightGrayText: UIColor {
        return UIColor(red: 57.0 / 255.0, green: 56.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
    }
    
    class var fitcatProgressGreen: UIColor {
        return UIColor(red: 71.0 / 255.0, green: 213.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
    }
    
    class var fitcatProgressGray: UIColor {
        return UIColor(white: 216.0 / 255.0, alpha: 1.0)
    }
    
    class var fitcatOrange: UIColor {
        return UIColor(red: 229.0 / 255.0, green: 79.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
    }
}

extension UIImage {
    
    func colored(with color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}





