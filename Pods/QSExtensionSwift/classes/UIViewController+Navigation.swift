//
//  UIViewController+SocialData.swift
//  QSExtensionSwift
//
//  Created by 火星人 on 16/4/17.
//  Copyright © 2016年 hqs. All rights reserved.


import UIKit

extension UIViewController{
    
    public func pushVC(_ vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func pushVCHidesBottomBar(_ vc: UIViewController){
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func popVC(){
        if self.navigationController != nil {
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    public func popRootVC(){
        if self.navigationController != nil {
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    
    public func presentVC(viewController: UIViewController, animated: Bool){
        self.presentVC(viewController: viewController, animated: animated, completion: nil)
    }
    
    public func presentVC(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil){
        if let nav = self.navigationController {
            nav.present(viewController, animated: animated, completion: completion)
        }
        else{
            self.present(viewController, animated: animated, completion: completion)
        }
    }
    
    public func dismissVC(animated: Bool){
        self.dismissVC(animated: animated, completion: nil)
    }
    
    public func dismissVC(animated: Bool, completion: (() -> Void)? = nil) {
        if let nav = self.navigationController {
            nav.dismiss(animated: animated, completion: completion)
        }
        else{
            self.dismiss(animated: animated, completion: completion)
        }
    }
    
    
}
