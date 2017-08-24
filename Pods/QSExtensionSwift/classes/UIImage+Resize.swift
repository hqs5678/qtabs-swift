//
//  UIImage+Color.swift
//  QSExtensionSwift
//
//  Created by hqs on 16/3/29.
//  Copyright © 2016年 hqs. All rights reserved.
//


import UIKit

extension UIImage {
    
    public func resizeImage() -> UIImage {
        
        return resizeImageWithLeft(0.5, top: 0.5)
    }
    
    // left: 0.0 - 1.0
    // top: 0.0 - 1.0
    public func resizeImageWithLeft(_ left: CGFloat, top: CGFloat) -> UIImage {
        
        let left = self.size.width * left - 1
        let top = self.size.height * top - 1
        let right = left
        let bottom = top
        return self.resizableImage(withCapInsets: UIEdgeInsetsMake(top, left, bottom, right))
    }
}
