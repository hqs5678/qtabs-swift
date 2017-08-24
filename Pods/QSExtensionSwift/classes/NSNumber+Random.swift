//
//  NSNumber+ Converte.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/5/23.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit

extension Int {
    
    // 0 ... Int.max
    public static func random() -> Int {
        return random(min: 0, max: Int.max - 1)
    }
    
    // 0 ... max
    public static func random(_ max: Int) -> Int{
        if max == Int.max {
            return random(min: 0, max: max - 1)
        }
        return random(min: 0, max: max)
    }
    
    // min ... max
    public static func random(min: Int, max: Int) -> Int{
        return Int(arc4random_uniform(UInt32(max + 1))) + min
    }
}

extension Int32 {
    
    // 0 ... Int32.max
    public static func random() -> Int32 {
        return random(min: 0, max: Int32.max - 1)
    }
    
    // 0 ... max
    public static func random(_ max: Int32) -> Int32{
        if max == Int32.max {
            return random(min: 0, max: max - 1)
        }
        return random(min: 0, max: max)
    }
    
    // min ... max
    public static func random(min: Int32, max: Int32) -> Int32{
        return Int32(arc4random_uniform(UInt32(max + 1))) + min
    }
}

extension UInt32 {
    
    // 0 ... Int32.max
    public static func random() -> UInt32 {
        return random(min: 0, max: UInt32.max - 1)
    }
    
    // 0 ... max
    public static func random(_ max: UInt32) -> UInt32{
        if max == UInt32.max {
            return random(min: 0, max: max - 1)
        }
        return random(min: 0, max: max)
    }
    
    // min ... max
    public static func random(min: UInt32, max: UInt32) -> UInt32{
        return arc4random_uniform(max + 1) + min
    }
}

