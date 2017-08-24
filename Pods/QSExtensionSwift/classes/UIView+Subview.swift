//
//  UIView+Subview.swift
//  QSExtensionSwift
//
//  Created by hqs on 16/4/19.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension UIView {
    
    public func removeAllSubviews(){
        let subViews = self.subviews
        if subViews.count == 0 {
            return
        }
        
        for v in subViews {
            v.removeFromSuperview()
        }
    }
}
