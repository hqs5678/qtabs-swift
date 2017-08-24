//
//  UITextFielExtension_Extension.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import UIKit

extension String {
    
    public var length: Int {
        return self.characters.count
    }
    
    public var isBlank: Bool {
        return self.trim().isEmpty
    }
    
    public func boundWithSize(_ size:CGSize ,font:UIFont) -> CGRect{
        let newStr:NSString = NSString(string: self)
        
        return newStr.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
    }
    
    // 去除字符串前后字符
    public func trim(_ characters: String) -> String{
        return self.trimmingCharacters(in: CharacterSet(charactersIn: characters))
    }
    
    // 去除字符串前后空格
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    public func toDataValue() -> Data? {
        return self.data(using: .utf8)
    }
    
    
    public func toArrayBy(separator: String) -> NSArray!{
        if self.length > 1 {
            let array = self.components(separatedBy: separator)
            return array as NSArray!
        }
        else {
            return nil
        }
    }
    
}

extension Optional where Wrapped == String {
    
    public var isBlank: Bool {
        return self?.isBlank ?? true
    }
    
    public var length: Int {
        return self?.characters.count ?? 0
    }
}
