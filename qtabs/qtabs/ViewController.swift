//
//  ViewController.swift
//  qtabs
//
//  Created by 火星人 on 2017/8/21.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tabs: QTabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "主页"
        
        tabs = QTabView(frame: self.view.frame)
        self.view.addSubview(tabs)
        let blue = UIColor(hexString: "1c50f6")
        tabs.indicatorColor = blue
        tabs.titleNormalColor = UIColor.darkGray
        tabs.titleSelectedColor = blue
        tabs.titleBackgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        tabs.layoutInSuperview(64, 0, 0, 0)
        tabs.titles = ["推荐", "娱乐明星", "体育", "新热点", "新闻", "帅哥", "美女"]
        
        for i in 0 ..< tabs.titles.count {
            let vc = VC1()
            vc.index = "\(tabs.titles[i]) \(i)"
            self.addChildViewController(vc)
        }
    }


}

