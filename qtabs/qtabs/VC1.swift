//
//  ViewController.swift
//  qtabs
//
//  Created by 火星人 on 2017/8/21.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

class VC1: UIViewController {

    let label = UILabel()
    
    var index = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.randomColor()
        
        self.view.addSubview(label)
        label.layoutInSuperview(0, 0, 0, 0)
        
        
        label.textAlignment = .center
        label.text = index
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
    }


}

