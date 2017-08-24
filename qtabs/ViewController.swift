//
//  ViewController.swift
//  qtabs
//
//  Created by 火星人 on 2017/8/21.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit
import QTabView

class ViewController: UIViewController {

    var tabs: QTabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "主页"
        
        tabs = QTabView(frame: self.view.frame)
        self.view.addSubview(tabs)
        
        let blue = UIColor(hexString: "1c50f6")
        // 设置指示器颜色
        tabs.indicatorColor = blue
        // 设置正常状态下标题的颜色
        tabs.titleNormalColor = UIColor.darkGray
        // 设置选中状态下标题的颜色
        tabs.titleSelectedColor = blue
        // 设置指示器的高度
        tabs.indicatorHeight = 2
        // 设置标题的背景颜色
        tabs.titleBackgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        // 自动布局，设置在父控件中的位置
        tabs.layoutInSuperview(20, 0, 0, 0)
        
        // 设置标题
        tabs.titles = ["推荐", "娱乐明星", "体育", "新热点", "新闻", "帅哥", "美女", "娱乐明星", "体育", "新热点", "新闻", "帅哥", "美女"]
        
        // 模拟每个标签页的内容
        for i in 0 ..< tabs.titles.count {
            let vc = VC1()
            vc.index = "\(tabs.titles[i]) \(i)"
            
            // 已addChildViewController 的方式设置标签页内容
            self.addChildViewController(vc)
        }
    }


}

