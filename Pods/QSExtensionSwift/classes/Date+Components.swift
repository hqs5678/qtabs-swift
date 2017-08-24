//
//  UITextFielExtension_Extension.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//


import UIKit

extension Date {
    
    
    public func components() -> DateComponents {
        let c = Calendar(identifier: Calendar.Identifier.republicOfChina)
        let comp =  (c as NSCalendar).components([.year, .month, .day, .weekday, .hour, .minute, .second], from: self)
        
        return comp
    }
    
    public var year: Int {
        return Int(yearString())!
    }
    
    public var month: Int {
        return Int(monthString())!
    }
    
    public var day: Int {
        return Int(dayString())!
    }
    
    public var hour: Int {
        return Int(hourString())!
    }
    
    public var minute: Int {
        return Int(minuteString())!
    }
    
    public var second: Int {
        return Int(secondString())!
    }
    
    public func yearString() -> String {
        return dateStringWithFormate(formate: "yyyy")
    }
    
    public func monthString() -> String {
        return dateStringWithFormate(formate: "MM")
    }
    
    public func dayString() -> String {
        return dateStringWithFormate(formate: "dd")
    }
    
    public func hourString() -> String {
        return dateStringWithFormate(formate: "HH")
    }
    
    public func minuteString() -> String {
        return dateStringWithFormate(formate: "mm")
    }
    
    public func secondString() -> String {
        return dateStringWithFormate(formate: "ss")
    }
    
    public func dateStringWithFormate(formate: String) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        
        return dateFormatter.string(from: self)
    }
    
    // 返回某个月的天数
    public static func dateSizeOfMonth(_ mon: Int, year: Int) -> Int{
        let size = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if mon == 2 {
            if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 {
                // 闰年
                return 29
            }
            else {
                return 28
            }
        }
        return size[mon - 1]
    }
   
}
