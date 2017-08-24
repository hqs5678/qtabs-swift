//
//  NSNumber+ Converte.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/23.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension Int {
    
    // 数字下标
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
    
    public var f: CGFloat {
        return CGFloat(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var uIntValue: UInt {
        return UInt(self)
    }
}

extension Int32 {
    
    public var f: CGFloat {
        return CGFloat(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var uIntValue: UInt {
        return UInt(self)
    }
}

extension Int64 {
    
    public var f: CGFloat {
        return CGFloat(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var uIntValue: UInt {
        return UInt(self)
    }
}

extension UInt {
    
    public var f: CGFloat {
        return CGFloat(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var intValue: Int {
        if self.doubleValue > Int.max.doubleValue {
            return -1
        }
        return Int(self)
    }
}

extension UInt32 {
    
    public var f: CGFloat {
        return CGFloat(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var intValue: Int {
        if self.doubleValue > Int.max.doubleValue {
            return -1
        }
        return Int(self)
    }
}

extension UInt64 {
    
    public var f: CGFloat {
        return CGFloat(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var intValue: Int {
        if self.doubleValue > Int.max.doubleValue {
            return -1
        }
        return Int(self)
    }
}

extension Float {
    
    public var intValue: Int {
        if self.doubleValue > Int.max.doubleValue {
            return -1
        }
        return Int(self)
    }
    
    public var f: CGFloat {
        return CGFloat(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
}

extension CGFloat {
    
    public var intValue: Int {
        return Int(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public var doubleValue: Double {
        return Double(self)
    }
}

extension Double {
    
    public var intValue: Int {
        return Int(self)
    }
    
    public var stringValue: String {
        return "\(self)"
    }
    
    public var f: CGFloat {
        return CGFloat(self)
    }
}

extension String {
    
    public var intValue: Int {
        let i = Int(self)
        if let i = i {
            return i
        }
        return 0
    }
    
    public var f: CGFloat {
        let i = Float(self)
        if let i = i {
            return i.f
        }
        return 0
    }
    
    public var floatValue: Float {
        let i = Float(self)
        if let i = i {
            return i
        }
        return 0
    }
    
}
