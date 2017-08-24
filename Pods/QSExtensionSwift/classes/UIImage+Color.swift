//
//  UIImage+Color.swift
//  QSExtensionSwift
//
//  Created by hqs on 16/3/29.
//  Copyright © 2016年 hqs. All rights reserved.
//



import UIKit
import Foundation

extension UIImage {
    
    public class func imageWithColor(_ color: UIColor) -> UIImage {
        
        let rect=CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return theImage!
    }
    
    public class func imageWithLinearGradientVertical(size: CGSize, color1: UIColor, color2: UIColor) -> UIImage {
        
        let startPoint = CGPoint(x: 0, y: size.height * 0.5)
        let endPoint = CGPoint(x: size.width, y: size.height * 0.5)
        return imageWithLinearGradient(size: size, color1: color1, color2: color2, startPoint: startPoint, endPoint: endPoint)
    }
    
    public class func imageWithLinearGradientHorizontal(size: CGSize, color1: UIColor, color2: UIColor) -> UIImage {
        
        let startPoint = CGPoint(x: size.width * 0.5, y: 0)
        let endPoint = CGPoint(x: size.width * 0.5, y: size.height)
        return imageWithLinearGradient(size: size, color1: color1, color2: color2, startPoint: startPoint, endPoint: endPoint)
    }
    
    public class func imageWithLinearGradient(size: CGSize, color1: UIColor, color2: UIColor, startPoint: CGPoint, endPoint: CGPoint) -> UIImage {
        
        let locations:[CGFloat] = [0.0, 1.0]
        return imageWithLinearGradient(size: size, colors: [color1, color2], locations: locations, startPoint: startPoint, endPoint: endPoint)
    }
    
    public class func imageWithLinearGradient(size: CGSize, colors: [UIColor], locations:[CGFloat], startPoint: CGPoint, endPoint: CGPoint) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var cgColors = [CGColor]()
        for color in colors {
            cgColors.append(color.cgColor)
        }
        let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)
        
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return theImage!
    }
    
    
    public class func imageWithRadialGradient(size: CGSize, color1: UIColor, color2: UIColor) -> UIImage {
        
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        let radius: CGFloat = max(size.width, size.height) * 0.5
        return imageWithRadialGradient(size: size, color1: color1, color2: color2, center: center, radius: radius)
    }
    
    public class func imageWithRadialGradient(size: CGSize, color1: UIColor, color2: UIColor, center: CGPoint, radius: CGFloat) -> UIImage {
        
        let startCenter = center
        let startRadius: CGFloat = 0
        let endCenter = startCenter
        var cgColors = [CGColor]()
        cgColors.append(color1.cgColor)
        cgColors.append(color2.cgColor)
        return imageWithRadialGradient(size: size, colors: [color1, color2], locations: [0.0, 1.0], startCenter: startCenter, startRadius: startRadius, endCenter: endCenter, endRadius: radius)
    }
    
    public class func imageWithRadialGradient(size: CGSize, colors: [UIColor], locations:[CGFloat], radius: CGFloat) -> UIImage {
        
        let startCenter = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        let startRadius: CGFloat = 0
        let endCenter = startCenter
        return imageWithRadialGradient(size: size, colors: colors, locations: locations, startCenter: startCenter, startRadius: startRadius, endCenter: endCenter, endRadius: radius)
    }
    
    public class func imageWithRadialGradient(size: CGSize, colors: [UIColor], locations:[CGFloat], startCenter: CGPoint, startRadius: CGFloat, endCenter: CGPoint, endRadius: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var cgColors = [CGColor]()
        for color in colors {
            cgColors.append(color.cgColor)
        }
        let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)
        
        context?.saveGState()
        context?.drawRadialGradient(gradient!, startCenter: startCenter, startRadius: startRadius, endCenter: endCenter, endRadius: endRadius, options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return theImage!
    }
}
