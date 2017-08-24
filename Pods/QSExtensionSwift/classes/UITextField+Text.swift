//
//  UITextField+Text.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/9.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension UITextField {
    
    public var textLength: Int {
        if let text = self.text {
            return text.length
        }
        return 0
    }
    
    public func equalTo(_ textField: UITextField) -> Bool {
        
        if self.text == textField.text {
            return true
        }
        else {
            return false
        }
    }
    
    public func setPlaceholderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSMutableAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : color])
    }
    
    // MARK: 过滤作用, 用在代理方法中, 设置输入内容为Float
    public func textWillChangedWithFloatNumber(replaceString: String) -> Bool {
        
        let number = "1234567890."
        var dotCount = 0
        if let text = self.text {
            for ch in text.characters {
                if ch == "." {
                    dotCount = 1
                    break
                }
            }
            
            if text.length == 1 {
                if text == "0" {
                    if replaceString.characters.first == "0" {
                        return false
                    }
                    else if replaceString.characters.first != "." {
                        self.text = replaceString
                        return false
                    }
                }
            }
            
            if text.length == 0 {
                if replaceString.characters.first == "." {
                    return false
                }
            }
        }
        
        
        
        for ch in replaceString.characters {
            
            if number.contains("\(ch)") {
                if ch == "." {
                    dotCount += 1
                    if dotCount > 1 {
                        return false
                    }
                }
            }
            else{
                return false
            }
        }
        
        return true
    }
    
    // MARK: 过滤作用, 用在代理方法中, 设置输入内容为Integer
    public func textWillChangedWithIntegerNumber(replaceString: String) -> Bool {
        
        let number = "1234567890"
        
        if let text = self.text {
            if replaceString.characters.first == "0" && text.length == 0 {
                return false
            }
        }
        
        
        for ch in replaceString.characters {
            
            if number.contains("\(ch)") {
                continue
            }
            else{
                return false
            }
        }
        
        return true
    }
}
