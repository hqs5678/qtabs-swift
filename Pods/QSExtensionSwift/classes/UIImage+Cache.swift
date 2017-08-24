//
//  Extensions.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//


import UIKit

extension UIImage{
  
    
    public func writeToFile(_ filePath:String){
        let data = UIImagePNGRepresentation(self)!
        try? data.write(to: URL(fileURLWithPath: filePath), options: [])
    }
    
    public func saveToFile(_ filePath: String){
        writeToFile(filePath)
    }
    
    public func data() -> Data?{
       return UIImagePNGRepresentation(self)
    }
}
