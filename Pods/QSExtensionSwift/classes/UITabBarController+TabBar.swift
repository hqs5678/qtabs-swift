//
//  UITabBarController_Extensions.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

import UIKit

extension UITabBarController{
    
    // 淡入
    public func fadeInTabBarWithDuration(_ duration:TimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        self.tabBar.alpha = 1.0
        UIView.commitAnimations()
    }
    public func fadeInTabBar(){
        fadeInTabBarWithDuration(0.2)
    }
    // 淡出
    public func fadeOutTabBarWithDuration(_ duration:TimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        self.tabBar.alpha = 0.0
        UIView.commitAnimations()
    }
    public func fadeOutTabBar(){
        fadeOutTabBarWithDuration(0.2)
    }
    // 推入
    public func pushInTabBarWithDuration(_ duration:TimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        var frame = self.tabBar.frame
        frame.origin.y = UIScreen.main.bounds.size.height - frame.size.height
        self.tabBar.frame = frame
        UIView.commitAnimations()
    }
    public func pushInTabBar(){
        pushInTabBarWithDuration(0.2)
    }
    // 推出
    public func pushOutTabBarWithDuration(_ duration:TimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        var frame = self.tabBar.frame
        frame.origin.y = UIScreen.main.bounds.size.height
        self.tabBar.frame = frame
        UIView.commitAnimations()
    }
    public func pushOutTabBar(){
        pushOutTabBarWithDuration(0.2)
    }
}
