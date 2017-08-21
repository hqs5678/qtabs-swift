//
//  QTabView.swift
//  qtabs
//
//  Created by 火星人 on 2017/8/21.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit
import QHorizontalTableView
import QSExtensionSwift

class QTabView: UIView, QHorizontalTableViewDelegate {

    var horizontalView: QHorizontalTableView!
    fileprivate var controller: UIViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        horizontalView = QHorizontalTableView(frame: self.frame)
        horizontalView.tableViewDelegate = self
        horizontalView.isPagingEnabled = true
        horizontalView.bounces = false
        self.addSubview(horizontalView)
        
        horizontalView.register(QHorizontalTableViewCell.classForCoder(), forCellWithReuseIdentifier: QHorizontalTableViewCell.className)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(QTabView.deviceOrientationDidChanged(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if controller == nil {
            
            if let next = self.next, next is UIViewController {
                controller = next as! UIViewController
                return
            }
            
            while true {
                
                if let superview = self.superview {
                    if let next = superview.next {
                        if next is UIViewController {
                            controller = next as! UIViewController
                            break
                        }
                    }
                    else{
                        break
                    }
                }
            }
        }
    }
    
    func deviceOrientationDidChanged(notification: Notification){
        horizontalView.reloadData()
    }
    
    
    func tableViewItemsCount(_ tableView: QHorizontalTableView) -> Int {
        if let controller = controller {
            return controller.childViewControllers.count
        }
        return 0
    }
    
    func tableView(_ tableView: QHorizontalTableView, didSelectRowAt index: Int) {
        
    }
    
    func tableView(_ tableView: QHorizontalTableView, widthForItemAt index: Int) -> CGFloat {
        return self.height
    }
    
    func tableView(_ tableView: QHorizontalTableView, cellForItemAt index: Int) -> QHorizontalTableViewCell {
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: QHorizontalTableViewCell.className, for: index)
        
        cell.addSubview(controller.childViewControllers[index].view)
        
        return cell
    }
    
    func tableView(_ tableView: QHorizontalTableView, willDisplay cell: QHorizontalTableViewCell, forItemAt index: Int) {
        
    }
    
    deinit {
        
    }
    
}
