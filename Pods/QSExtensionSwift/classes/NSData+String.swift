//
//  UITextFielExtension_Extension.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import UIKit

extension Data{
    
    
    public func toString() -> String{
        let str = NSString(data: self, encoding: String.Encoding.utf8.rawValue)
        return str! as String
    }
    
    public func toJsonObject() -> AnyObject {
        return try! JSONSerialization.jsonObject(with: self, options: .allowFragments) as AnyObject
    }
    
    
}
