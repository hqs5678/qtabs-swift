//
//  UILabel+Text.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension UILabel {
    
    // 注意!!!!!
    // 在使用富文本时使用该方法有效  在没有设置 attributedText时是不起作用的
    public func boundWithSize(_ size: CGSize) -> CGRect {
        
        return self.attributedText!.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
    }
}

