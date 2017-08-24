//
//  UITextFielExtension_Extension.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import UIKit

extension UIView{
    
    
    public var cornerRadius: CGFloat {
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    public var borderWidth: CGFloat {
        set(newValue) {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    public var borderColor: CGColor? {
        set(newValue) {
            self.layer.borderColor = newValue
        }
        get {
            return self.layer.borderColor
        }
    }
    
    
    
    public func setCornerRadius(_ corners: UIRectCorner, cornerRadii: CGSize){
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let shapLayer = CAShapeLayer()
        shapLayer.frame = self.bounds
        shapLayer.path = maskPath.cgPath
        
        self.layer.mask = shapLayer
    }
    
    
     
}
