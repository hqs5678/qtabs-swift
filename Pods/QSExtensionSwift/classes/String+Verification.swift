//
//  String+Verification.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/4/16.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension String{

    // 判断是否合法的手机号
    public func isPhoneNumber() -> Bool{
        
        let regex = "1+[0-9]{10}"
        
        let test: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return test.evaluate(with: self)
    }
    
    // 判断是否合法邮箱
    public func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: self)
    }
}
