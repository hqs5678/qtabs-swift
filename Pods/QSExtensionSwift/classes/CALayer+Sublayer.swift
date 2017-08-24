//
//  UIView+Subview.swift
//  QSExtensionSwift
//
//  Created by hqs on 16/4/19.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension CALayer {
    
    public func removeAllSublayers(){
        let sublayers = self.sublayers
        
        if let sublayers = sublayers {
            for v in sublayers {
                v.removeFromSuperlayer()
            }
        }
    }
}
