//
//  UITextField+Text.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/9.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension UITextView {
    
    public var textLength: Int {
        if let text = self.text {
            return text.length
        }
        return 0
    }
    
    public func equalTo(_ textView: UITextView) -> Bool {
        
        if self.text == textView.text {
            return true
        }
        else {
            return false
        }
    }
}
