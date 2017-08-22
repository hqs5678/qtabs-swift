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
    var titleView: QHorizontalTableView!
    fileprivate var controller: UIViewController!
    fileprivate var curIndex = -1
    fileprivate var preOrientation = UIDeviceOrientation.unknown
    var titleFontSize = 17.f
    var titlePadding = 10.f
    lazy var indicator = CALayer()
    var indicatorHeight = 3.f
    var indicatorColor = UIColor.gray
    
    fileprivate var preX = 0.f
    
    var titles: [String]! {
        didSet{
            didSetTitles()
        }
    }
    
    var titleFrames: [CGRect]!
    
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
        
        titleView = QHorizontalTableView(frame: CGRect(x: 0, y: 0, width: self.width, height: 50))
        titleView.backgroundColor = UIColor.white
        titleView.showsVerticalScrollIndicator = false
        titleView.showsHorizontalScrollIndicator = false
        titleView.bounces = false
        titleView.tableViewDelegate = self
        titleView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        titleView.register(ItemCell.classForCoder(), forCellWithReuseIdentifier: ItemCell.className)
        
        indicator.frame = CGRect(x: 0, y: titleView.height - indicatorHeight, width: 39, height: indicatorHeight)
        indicator.backgroundColor = indicatorColor.cgColor
        self.titleView.layer.addSublayer(indicator)
        
        self.addSubview(titleView)
        self.addSubview(horizontalView)
        horizontalView.layoutInSuperview(titleView.height, 0, 0, 0)
        
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
    
    func didSetTitles(){
        titleFrames = [CGRect]()
        for t in titles {
            let frame = t.boundWithSize(CGSize(width: 100, height: self.height), font: UIFont.systemFont(ofSize: titleFontSize))
            titleFrames.append(frame)
        }
        titleView.reloadData()
        self.tableView(titleView, didSelectRowAt: 0)
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
        
        titleView.width = self.width
        titleView.reloadData()
        print(curIndex)
        horizontalView.reloadData()
        if curIndex != -1 {
            horizontalView.setContentOffset(CGPoint(x: curIndex.f * self.width, y: 0), animated: false)
        }
    }
    
    
    func tableViewItemsCount(_ tableView: QHorizontalTableView) -> Int {
        
        if tableView == horizontalView {
            if let controller = controller {
                return controller.childViewControllers.count
            }
        }
        else{
            if let titles = titles {
                return titles.count
            }
        }
        return 0
    }

    
    func tableView(_ tableView: QHorizontalTableView, widthForItemAt index: Int) -> CGFloat {
        if tableView == horizontalView {
            return self.width
        }
        else{
            return titleFrames[index].size.width + titlePadding + titlePadding
        }
    }
    
    func tableView(_ tableView: QHorizontalTableView, cellForItemAt index: Int) -> QHorizontalTableViewCell {
        
        if tableView == horizontalView {
            let cell = tableView.dequeueReusableCell(withReuseIdentifier: QHorizontalTableViewCell.className, for: index)
            let view = controller.childViewControllers[index].view as UIView
            cell.removeAllSubviews()
            cell.addSubview(view)
            cell.tag = index
            view.layoutInSuperview(0, 0, 0, 0)
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withReuseIdentifier: ItemCell.className, for: index) as! ItemCell
            var frame = titleFrames[index]
            frame.origin.x = titlePadding
            frame.origin.y = (titleView.height - frame.size.height) * 0.5
            cell.titleLabel.frame = frame
            cell.titleLabel.text = titles[index]
            cell.titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: QHorizontalTableView, didSelectRowAt index: Int) {
        if tableView == titleView {
            let cell = self.tableView(titleView, cellForItemAt: index) as! ItemCell
            
            let rect = cell.titleLabel.convert(cell.titleLabel.bounds, to: self) as CGRect
            indicator.x = rect.origin.x
            indicator.width = rect.size.width
        
            horizontalView.contentOffset = CGPoint(x: index.f * self.width, y: 0)
        }
    }
    
    func centerX(rect: CGRect) -> CGFloat {
        return (rect.maxX + rect.minX) * 0.5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == horizontalView {
            let sx = horizontalView.contentOffset.x
            let index = sx.intValue / self.width.intValue
            let nextIndex = index + 1
            if nextIndex >= titles.count {
                return
            }
            let offset = sx - index.f * self.width
            
            var cell = self.tableView(titleView, cellForItemAt: index) as! ItemCell
            let rect0 = cell.titleLabel.convert(cell.titleLabel.bounds, to: self) as CGRect
            
            cell = self.tableView(titleView, cellForItemAt: nextIndex) as! ItemCell
            let rect1 = cell.titleLabel.convert(cell.titleLabel.bounds, to: self) as CGRect
            
            let w0 = rect1.minX - rect0.minX
            let w1 = rect1.maxX - rect0.maxX
            
            var t = offset / self.width
            var left = 0.f
            var right = 0.f
            var a0 = 0.f
            var v0 = 0.f
            var a1 = 0.f
            var v1 = 0.f
            var direct = 1.f
            
            if sx > preX {
                // 向左滑
                a0 = w0 * 2
                v0 = 0
                
                a1 = w1 * -2
                v1 = -a1
                
                left = rect0.origin.x
                right = rect0.maxX
            }
            else {
                a0 = w0 * -2
                v0 = -a0
                
                a1 = w1 * 2
                v1 = 0
                
                left = rect1.origin.x
                right = rect1.maxX
                
                t = 1 - t
                direct = -1.f
            }
            
            left += (v0 * t + 0.5 * a0 * t * t) * direct
            right += (v1 * t + 0.5 * a1 * t * t) * direct
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            indicator.x = left
            indicator.width = right - left
            CATransaction.commit()
            
            if offset == 0 {
                
                
            }
            
            
            preX = sx
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == horizontalView {
            curIndex = (scrollView.contentOffset.x / self.width).intValue
        }
        let index = horizontalView.contentOffset.x.intValue / self.width.intValue
        let cell = self.tableView(titleView, cellForItemAt: index) as! ItemCell
        let rect = cell.titleLabel.convert(cell.titleLabel.bounds, to: self) as CGRect
        let targetCenter = centerX(rect: rect)
        let point = CGPoint(x: targetCenter - self.width * 0.5, y: 0)
        titleView.setContentOffset(point, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
}

fileprivate class ItemCell: QHorizontalTableViewCell {
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        titleLabel = UILabel(frame: self.frame)
        self.addSubview(titleLabel)
        titleLabel.textColor = UIColor.brown
    }
}
