//
//  UIView+Constaint.swift
//  myconstaint
//
//  Created by Apple on 16/9/22.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

extension UIView {
    
    public func centerInView(view: UIView) {
        self.centerInView(view: view, size: self.frame.size)
    }
    
    public func centerInSuperview() {
        let view = self.superview
        if let v = view {
            centerInView(view: v)
        }
    }
    
    public func centerInView(view: UIView, size: CGSize) {
        self.centerInView(view: view, width: size.width, height: size.height)
    }
    
    public func centerInView(view: UIView, height: CGFloat) {
        self.centerInView(view: view, width: self.frame.size.width, height: height)
    }
    
    public func centerInView(view: UIView, width: CGFloat) {
        self.centerInView(view: view, width: width, height: self.frame.size.height)
    }
    
    public func centerInView(view: UIView, width: CGFloat, height: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if self.superview != view {
            self.removeFromSuperview()
            view.addSubview(self)
        }
        
        // 居中
        let centerX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        
        view.addConstraints([centerX, centerY])
        
        // 宽高
        let width = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        let height = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        
        self.addConstraints([width, height])
    }
    
    
    
    
    public func layoutInSuperview(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        
        if let view = self.superview {
            layoutInView(view: view, top, left, bottom, right)
        }
    }
    public func layoutInView(view: UIView, edgeInsets: UIEdgeInsets) {
        layoutInView(view: view, edgeInsets.top, edgeInsets.left, edgeInsets.bottom, edgeInsets.right)
    }
    
    public func layoutInView(view: UIView, _ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if self.superview != view {
            self.removeFromSuperview()
            view.addSubview(self)
        }
        
        let left = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: left)
        let right = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: right * -1)
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: top)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: bottom * -1)
        
        view.addConstraints([left, right, top, bottom])
        
    }
    
    
}
