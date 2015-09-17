//
//  RGBColorPicker.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 17/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import UIKit

class RGBColorPicker {
    
    class func colorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}