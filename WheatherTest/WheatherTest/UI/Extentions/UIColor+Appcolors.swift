//
//  UIColor+Appcolors.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 19.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func RGB(r: Int, g: Int, b: Int, alpha: Float = 1) -> UIColor {
        return UIColor.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(alpha))
    }
    
    static func appSunnyColor() -> UIColor {
        return self.RGB(r: 230, g: 255, b: 255)
    }
}

