//
//  String+Substring.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/22.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension String {
    
    subscript(index: Int) -> String {
        return self.charAt(index: index)
    }
    
    public func substringToIndex(_ index: Int) -> String{
        
        if index < 0 || index > self.length - 1{
            return "fatal index"
        }
        let endIndex = self.index(self.startIndex, offsetBy: index) as Index
        return self.substring(to: endIndex)
    }
    
    public func substringFromIndex(_ index: Int) -> String{
        
        if index < 0 || index > self.length - 1{
            return "fatal index"
        }
        let startIndex = self.index(self.startIndex, offsetBy: index)
        return self.substring(from: startIndex)
    }
    
    public func substringFromIndex(_ from: Int, length len: Int) -> String {
        
        let to = from + len
        return self.substringFromIndex(from, toIndex: to)
    }

    
    public func substringFromIndex(_ from: Int, toIndex to: Int) -> String {
        
        if from < 0 || from > self.length - 1 || to > self.length || to < 0 || from > to {
            return "fatal index"
        }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        let range = Range(uncheckedBounds: (startIndex, endIndex))
        return self.substring(with: range)
    }
    
    public func indexOf(string: String) -> Int {
        let range = (self as NSString).range(of: string)
        return range.location
    }
    
    public func charAt(index: Int) -> String{
        return self.substringFromIndex(index, length: 1)
    }
    
}
