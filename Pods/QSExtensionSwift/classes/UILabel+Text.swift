//
//  UILabel+Text.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension UILabel {
    
    public var textLength: Int {
        if let text = self.text {
            return text.length
        }
        return 0
    }
        
    public func equalTo(_ label: UILabel) -> Bool {
        
        if self.text == label.text {
            return true
        }
        else {
            return false
        }
    }
    
}

