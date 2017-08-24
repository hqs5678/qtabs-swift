//
//  String+Security.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/4/16.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit
import Foundation
import SwiftHashing

extension String {
    
//    func md5(string: String) -> String {
//        
//        let t = NSTask()
//        t.launchPath = "/sbin/md5"
//        t.arguments = ["-q", "-s", string]
//        t.standardOutput = Pipe()
//        
//        t.launch()
//        
//        let outData = t.standardOutput.fileHandleForReading.readDataToEndOfFile()
//        var outBytes = [UInt8](count:outData.length, repeatedValue:0)
//        outData.getBytes(&outBytes, length: outData.length)
//        
//        var outString = String(bytes: outBytes, encoding: NSASCIIStringEncoding)
//        
//        assert(outString != nil, "failed to md5 input string")
//        
//        return outString!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
//    }
//    
//    public var md5: String! {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
    
    public var md5: String{
        return md5Hash(self)
    }
    
    public func hmac(secret: String) -> String{
        return hmacHash(secret, self)
    }
    
//    public var sha1: String! {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_SHA1(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
    
    public var base64String: String!{
        let plainData = data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String!
    }
    
    public var fromBase64String: String! {
        
        let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
        if data == nil {
            return self
        }
        return String.init(data: data!, encoding: String.Encoding.utf8)
    }
    
    
    public static func uuid() -> String {
        return UUID().uuidString
    }
    
}
