//
//  UIViewController+SocialData.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/4/17.
//  Copyright © 2016年 hqs. All rights reserved.


import UIKit

extension UINavigationController{
    
    private struct AssociatedKeys {
        static var popToRootVC = "popToRootVC"
    }
    
    public var popToRootVC: Bool? {
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.popToRootVC, newValue, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.popToRootVC) as? Bool
        }
        
    }
    
    
}
