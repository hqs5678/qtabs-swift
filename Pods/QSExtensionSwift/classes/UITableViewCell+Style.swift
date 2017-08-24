//
//  UITabBarController_Extensions.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import UIKit

extension UITableViewCell{
    
    public func setSelectedBackgroundColor(_ color: UIColor){
        
        let bgview = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        bgview.backgroundColor = color
        self.selectedBackgroundView = bgview
    }
}
