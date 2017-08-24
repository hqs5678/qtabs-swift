//
//  UIImageView+OSS.swift
//  initproject-swift
//
//  Created by hqs on 16/4/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
//    public func setOSSObjectKey(_ objectKey: String){
//        self.setOSSObjectKey(objectKey, placeholderImage: nil)
//    }
//    
//    public func setOSSObjectKey(_ objectKey: String, placeholderImage: UIImage?){
//        setOSSObjectKey(objectKey, placeholderImage: placeholderImage, downloadProgress: { (progress) in
//            
//        }) { (data) in
//            DispatchQueue.main.async(execute: {
//                
//                self.image = UIImage(data: data)
//            })
//        }
//    }
//    
//    public func setOSSObjectKey(_ objectKey: String, placeholderImage: UIImage?, downloadProgress: @escaping ((_ progress: CGFloat) -> ()), completion: @escaping ((_ data: Data) -> Void)){
//        
//        let fileName = objectKey.md5
//        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] + "/"
//        let file = cachePath + fileName!
//        let fileM = FileManager.default
//        
//        
//        appPrint(file)
//        
//        // 判读文件是否存在
//        if fileM.fileExists(atPath: file) {
//            self.image = UIImage(contentsOfFile: file)
//            completion(try! Data(contentsOf: URL(fileURLWithPath: file)))
//        }
//        else{
//            if placeholderImage != nil {
//                self.image = placeholderImage
//            }
//            
//            OSSHelper.sharedInstance.downloadFile(objectKey, downloadProgress: {
//                (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite, progress) in
//                
//                appPrint("\(objectKey) -> \(progress)")
//                
//                downloadProgress(progress: progress)
//                
//            }){
//                (task) in
//                if task.error == nil {
//                    let result = task.result
//                    let data:Data = result.value(forKey: "downloadedData") as! Data
//                    
//                    completion(data: data)
//                    
//                    // 保存文件
//                    try? data.write(to: URL(fileURLWithPath: file), options: [])
//                    
//                }
//                else{
//                    appPrint(task.error)
//                }
//            }
//        }
//    }


}
