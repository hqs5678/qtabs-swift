//
//  UIColor+ST.swift
//  SwiftDrawRect
//
//  Created by 沈兆良 on 16/3/8.
//  Copyright © 2016年 沈兆良. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    public convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    public class func randomColor() -> UIColor
    {
        let hue: CGFloat = (CGFloat(arc4random() % 256) / 256.0 );  //  0.0 to 1.0
        let saturation: CGFloat = (CGFloat(arc4random() % 128) / 256.0) + 0.5;  //  0.5 to 1.0, away from white
        let brightness: CGFloat = (CGFloat(arc4random() % 128) / 256.0) + 0.2;  //  0.5 to 1.0, away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    public class func RGBA(_ r: Int, g: Int, b: Int, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
    
    public class func RGB(_ r:Int, g:Int, b:Int) -> UIColor {
        return RGBA(r, g: g, b: b, a: 1)
    }
    
    public func colorR() -> CGFloat {
        
        let colors = self.cgColor.components
        return colors![0] * 255.0
    }
    
    public func colorG() -> CGFloat {
        
        let colors = self.cgColor.components
        return colors![1] * 255.0
    }
    
    public func colorB() -> CGFloat {
        
        let colors = self.cgColor.components
        return colors![2] * 255.0
    }
    
    public func colorA() -> CGFloat {
        let colors = self.cgColor.components
        return colors![3]
    }
    
    
}
