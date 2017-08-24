//
//  UILabel+Text.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/15.
//  Copyright © 2016年 hqs. All rights reserved.
//


import UIKit

extension UILabel {
    
    public func setFontColor(_ fontColor: UIColor, range: NSRange){
        
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: fontColor, range: range)
        
        self.attributedText = attributedString
    }
    
    // 设置行间距
    public func setTextLineSpacing(_ lineSpacing: CGFloat) {
        
        let len = (self.text! as NSString).length
        let range = NSMakeRange(0, len)
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        let sourceParagraphStyle = attributedString.attribute(NSParagraphStyleAttributeName, at: 0, longestEffectiveRange: nil, in: range)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.firstLineHeadIndent = (sourceParagraphStyle as AnyObject).firstLineHeadIndent
        paragraphStyle.paragraphSpacing = 0
        paragraphStyle.minimumLineHeight = 4
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        self.attributedText = attributedString
    }
    
    // 首行缩进
    public func setFirstLineIndentation(_ indentation: CGFloat) {
        
        let len = (self.text! as NSString).length
        let range = NSMakeRange(0, len)
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        let sourceParagraphStyle = attributedString.attribute(NSParagraphStyleAttributeName, at: 0, longestEffectiveRange: nil, in: range)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = (sourceParagraphStyle as AnyObject).lineSpacing
        paragraphStyle.firstLineHeadIndent = indentation
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        self.attributedText = attributedString
    }
}

