//
//  Extensions UIColor.swift
//  GpsModulev2
//
//  Created by Marcos Rollón Rivas on 26/2/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb ( red: CGFloat, green : CGFloat, blue : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func rgbWithAlpha ( red : CGFloat, green : CGFloat, blue : CGFloat , alpha : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    
    static func googleRed() -> UIColor{
        return UIColor.rgb(red: 220, green: 78, blue: 65)
    }
    static func googleRedWithAlpha( alpha : CGFloat) -> UIColor{
        return UIColor.rgbWithAlpha(red: 220, green: 78, blue: 65, alpha: alpha)
    }
    
    static func facebookBlue() -> UIColor{
        return UIColor.rgb(red: 59, green: 89, blue: 152)
    }
    
    static func mainTurquoise() -> UIColor{
        return UIColor.rgb(red: 78, green: 205, blue: 196)
    }
    static func mainTurquoiseWithAlpha(alpha: CGFloat)-> UIColor{
        return UIColor.rgbWithAlpha(red: 78, green: 205, blue: 196, alpha: alpha)
    }
    
    static func lightBlue() -> UIColor{
        return UIColor.hexStringToUIColor(hex: "#8EDCE6")
    }
    
    static func mainGreen() -> UIColor{
        return UIColor.rgb(red: 178, green: 219, blue: 191)
    }
    static func mainGreenWithAlpha(alpha : CGFloat) -> UIColor{
        return UIColor.rgbWithAlpha(red: 178, green: 219, blue: 192, alpha: alpha)
    }
    
    static func warningYellow() -> UIColor {
        return UIColor.rgb(red: 220, green: 174, blue: 66)
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
