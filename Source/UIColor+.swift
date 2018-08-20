//
//  UIColor+.swift
//  OSComponents
//
//  Created by AppSimples on 15/08/18.
//  Copyright © 2018 OutSmart. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public class func fromRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    public class func primary() -> UIColor {
        return UIColor.fromRGBA(r: 10, g: 218, b: 186, a: 1)
    }
    
    public class func primaryDark() -> UIColor {
        return UIColor.fromRGBA(r: 39, g: 0, b: 93, a: 1)
    }
    
    public class func accent() -> UIColor {
        return UIColor.fromRGBA(r: 39, g: 0, b: 93, a: 1)
    }
    
    public class func blackTransparent() -> UIColor {
        return UIColor.fromRGBA(r: 0, g: 0, b: 0, a: 0.6)
    }
    
    public class func whiteTransparent() -> UIColor {
        return UIColor.fromRGBA(r: 255, g: 255, b: 255, a: 0.6)
    }
}
