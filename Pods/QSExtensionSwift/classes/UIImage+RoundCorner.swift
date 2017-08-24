//
//  UIImageView+RoundCorner.swift
//  testRoundImage
//
//  Created by 火星人 on 16/3/10.
//  Copyright © 2016年 火星人. All rights reserved.
//

import UIKit

extension UIImage {
    
    public func roundedCornerImage(radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        UIGraphicsGetCurrentContext()?.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners,
                cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        UIGraphicsGetCurrentContext()?.clip()
        
        self.draw(in: rect)
        UIGraphicsGetCurrentContext()?.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return output!
    }
    
    public func circleImage(_ sizetoFit: CGSize) -> UIImage {
        let radius: CGFloat = sizetoFit.width * 0.5
        return roundedCornerImage(radius: radius, sizetoFit)
    }
}
