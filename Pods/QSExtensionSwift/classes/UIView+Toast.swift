//
//  UITextFielExtension_Extension.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import UIKit

extension UIView{
    
    public func makeToast(_ message:String){
        self.makeToast(message, duration: 0, position: CGPoint.zero, fontSize: 0, animate: true)
    }
    
    public func makeToast(_ message:String, animate:Bool){
        self.makeToast(message, duration: 0, position: CGPoint.zero, fontSize: 0, animate: animate)
    }
    
    public func makeToast(_ message:String, position:CGPoint){
        self.makeToast(message, duration: 0, position: position, fontSize: 0, animate: true)
    }
    
    public func makeToast(_ message:String, duration:UInt32){
        self.makeToast(message, duration: duration, position: CGPoint.zero, fontSize: 0, animate: true)
    }
    
    public func makeToast(_ message:String, duration:UInt32, animate:Bool){
        self.makeToast(message, duration: duration, position: CGPoint.zero, fontSize: 0, animate: animate)
    }
    
    public func makeToast(_ message:String, position:CGPoint, animate:Bool){
        self.makeToast(message, duration: 0, position: position, fontSize: 0, animate: animate)
    }
    
    public func makeToast(_ message:String, duration:UInt32, position:CGPoint, animate:Bool){
        self.makeToast(message, duration: duration, position: position, fontSize: 0, animate: animate)
    }
    
    public func makeToast(_ message:String, duration:UInt32, position:CGPoint, fontSize:CGFloat, animate:Bool){
        
        let toastLabel = UILabel()
        let toast = UIView()
        
        var fsize = fontSize
        if fsize <= 0 {
            fsize = 16
        }
        toastLabel.font = UIFont(name: toastLabel.font.fontName, size: fsize)
        toastLabel.textAlignment = NSTextAlignment.center
        toastLabel.backgroundColor = UIColor.clear
        toastLabel.textColor = UIColor.white
        toastLabel.text = message
        toastLabel.sizeToFit()
        toast.addSubview(toastLabel)
        
        var frame = toastLabel.frame
        frame.size.width += 20
        frame.size.height += 15
        toast.frame = frame
        toastLabel.frame = frame
        if position.equalTo(CGPoint.zero) {
            toast.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height - frame.size.height)
        }
        else {
            toast.center = position
        }
        
        toast.backgroundColor = UIColor.black
        toast.layer.cornerRadius = 5
        self.addSubview(toast)
        
        if animate {
            toast.alpha = 0
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                toast.alpha = 1
            }, completion: { (Bool) -> Void in
                
            })
        }
       
        
        let queue = DispatchQueue(label: "toast_queue", attributes: [])
        queue.async(execute: { () -> Void in
            if duration <= 0 {
                sleep(2)
            }
            else{
                sleep(duration)
            }
            DispatchQueue.main.sync(execute: { () -> Void in
                self.removeToast(toast, animate: true)
            })
        })
    }
    
    public func removeToast(_ toast:UIView, animate:Bool) {
        if animate{
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                toast.alpha = 0
            }, completion: { (Bool) -> Void in
                toast.removeFromSuperview()
            })
        }
        else{
            toast.removeFromSuperview()
        }
        
    }
   
    
}
