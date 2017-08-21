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
    fileprivate var curIndex = -1
    fileprivate var preOrientation = UIDeviceOrientation.unknown
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        
        self.backgroundColor = UIColor.white
        
        horizontalView = QHorizontalTableView(frame: self.frame)
        horizontalView.backgroundColor = UIColor.white
        horizontalView.tableViewDelegate = self
        horizontalView.isPagingEnabled = true
        horizontalView.bounces = false
        horizontalView.showsVerticalScrollIndicator = false
        horizontalView.showsHorizontalScrollIndicator = false
        
        self.addSubview(horizontalView)
        horizontalView.layoutInSuperview(0, 0, 0, 0)
        
        horizontalView.register(QHorizontalTableViewCell.classForCoder(), forCellWithReuseIdentifier: QHorizontalTableViewCell.className)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
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
    
    
    func doInMainThreadAfter(_ delay:Double, task:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(delay * 1000)), execute: task)
    }
    
    func deviceOrientationDidChanged(){
        
        let device = UIDevice.current
        switch device.orientation {
        case .portrait, .landscapeLeft, .landscapeRight:
            if preOrientation != .unknown {
                if preOrientation != device.orientation {
                    updateTableView()
                }
            }
            preOrientation = device.orientation
            break
        default:
            break
        }

    }
    
    func updateTableView(){
        
        curIndex = (horizontalView.contentOffset.x / self.height).intValue
        print(curIndex)
        horizontalView.reloadData()
        if curIndex != -1 {
            horizontalView.setContentOffset(CGPoint(x: curIndex.f * self.width, y: 0), animated: false)
        }
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
        print(self.width)
        return self.width
    }
    
    func tableView(_ tableView: QHorizontalTableView, cellForItemAt index: Int) -> QHorizontalTableViewCell {
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: QHorizontalTableViewCell.className, for: index)
        let view = controller.childViewControllers[index].view as UIView
        cell.removeAllSubviews()
        cell.addSubview(view)
        cell.tag = index
        view.layoutInSuperview(0, 0, 0, 0)
        
        return cell
    }
    
    func tableView(_ tableView: QHorizontalTableView, willDisplay cell: QHorizontalTableViewCell, forItemAt index: Int) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
}
