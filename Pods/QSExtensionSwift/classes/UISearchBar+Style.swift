//
//  UILabel+Text.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    public func setTextColor(color: UIColor){
        let searchField = self.value(forKey: "_searchField") as? UITextField
        // 输入文本颜色
        searchField?.textColor = color
        // 默认文本颜色
        searchField?.setValue(color, forKeyPath: "_placeholderLabel.textColor")
    }
}

