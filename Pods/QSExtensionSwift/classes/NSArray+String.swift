//
//  File.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/9.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension NSArray {
    
    public func toString(separator: String) -> String{
        
        if self.count  == 0 {
            return ""
        }
        let str = NSMutableString()
        for obj in self {
            str.append(obj as! String)
            str.append(separator)
        }
        return str.substring(to: str.length - separator.length)
    }

}
