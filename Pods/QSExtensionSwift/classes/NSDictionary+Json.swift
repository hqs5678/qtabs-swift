//
//  UITextFielExtension_Extension.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import UIKit

extension NSDictionary{
    
    public func toJsonString() -> String{
        let data:Data = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions())
        
        return data.toString()
    }
    
}
