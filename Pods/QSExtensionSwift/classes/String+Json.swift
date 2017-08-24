//
//  String+Json.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/4/21.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

extension String {
    
    public func toJsonObject() -> AnyObject? {
        
        let data = self.data(using: String.Encoding.utf8)
        return try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject?
    }
}
