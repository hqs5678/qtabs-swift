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
    fileprivate var curIndex = 0
    fileprivate var preOrientation = UIDeviceOrientation.unknown
    var titleFontSize = 17.f
    var titlePadding = 10.f
    fileprivate lazy var indicator = CALayer()
    var indicatorHeight = 3.f {
        didSet{
            didSetIndicatorHeight()
        }
    }
    var indicatorColor = UIColor.brown {
        didSet{
            indicator.backgroundColor = indicatorColor.cgColor
        }
    }
    var titleNormalColor = UIColor.black {
        didSet{
            titleView.reloadData()
        }
    }
    var titleSelectedColor = UIColor.brown {
        didSet{
            titleView.reloadData()
        }
    }
    
    fileprivate var preX = 0.f
    
    var titles: [String]! {
        didSet{
            didSetTitles()
        }
    }
     
    var titleBounds: [CGRect]!
    lazy var titleLabelFrames = [Int : CGRect]()
    
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
    
    func didSetIndicatorHeight(){
        indicator.height = indicatorHeight
        indicator.y = self.height - indicatorHeight
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
        titleBounds = [CGRect]()
        for t in titles {
            let frame = t.boundWithSize(CGSize(width: 100, height: self.height), font: UIFont.systemFont(ofSize: titleFontSize))
            titleBounds.append(frame)
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
            return titleBounds[index].size.width + titlePadding + titlePadding
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
            
            if curIndex != index {
                cell.titleLabel.textColor = titleNormalColor
            }
            else{
                cell.titleLabel.textColor = titleSelectedColor
            }
            cell.titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
            cell.titlePadding = titlePadding
            cell.cellHeight = self.titleView.height
            cell.titleLabel.text = titles[index]
            cell.titleBound = titleBounds[index]
            
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
            adjustTitleViewToCenter()
        }
    }
    
    func centerX(rect: CGRect) -> CGFloat {
        return (rect.maxX + rect.minX) * 0.5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == horizontalView {
            let sx = horizontalView.contentOffset.x
            let index = sx.intValue / self.width.intValue
            
            let offset = sx - index.f * self.width
            if offset == 0 {
                curIndex = index
                titleView.reloadData()
                return
            }
            let nextIndex = index + 1
            if nextIndex >= titles.count {
                return
            }
            
            let rect0 = labelRect(index: index)
            let rect1 = labelRect(index: nextIndex)
            
            let w0 = rect1.minX - rect0.minX
            let w1 = rect1.maxX - rect0.maxX
            
            let c0 = centerX(rect: rect0)
            let c1 = centerX(rect: rect1)
            var d = c1 - c0
            var px = 0.f
            
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
                
                if c0 + d - self.width * 0.5 > titleView.contentSize.width - self.width {
                    d -= c0 + d + self.width * 0.5 - titleView.contentSize.width
                }
                else if c0 - self.width  * 0.5 < 0 {
                    d -= self.width * 0.5 - c0
                }
                var ox = c0 - self.width * 0.5
                if ox < 0 {
                    ox = 0
                }
                px = ox + d * t
                
                
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
                
                var flag = true
                if c0 - self.width * 0.5 < 0 {
                    d -= self.width * 0.5 - c0
                    px = c1 - d * t - self.width * 0.5
                    flag = false
                }
                else if c0 + d + self.width * 0.5 > titleView.contentSize.width {
                    d -= c0 + d + self.width * 0.5 - titleView.contentSize.width
                }
                if flag {
                    px = c0 + d * (1 - t) - self.width * 0.5
                }
                
            }
            
            left += (v0 * t + 0.5 * a0 * t * t) * direct
            right += (v1 * t + 0.5 * a1 * t * t) * direct
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            indicator.x = left
            indicator.width = right - left
            
            if px < 0 {
                px = 0
            }
            else {
                let maxX = titleView.contentSize.width - self.width
                if px > maxX {
                    px = maxX
                }
            }
            let point = CGPoint(x: px, y: 0)
            titleView.contentOffset = point
            
            CATransaction.commit()
            
            
            preX = sx
        }
    }
    
    func labelRect(index: Int) -> CGRect{
        if let rect = titleLabelFrames[index] {
            return rect
        }
        else{
            let cell = self.tableView(titleView, cellForItemAt: index) as! ItemCell
            let rect = cell.titleLabel.convert(cell.titleLabel.bounds, to: self) as CGRect
            
            if index > 0 {
                let preRect = labelRect(index: index - 1)
                if rect.origin.x > preRect.origin.x && rect.origin.y < 0 {
                    titleLabelFrames[index] = rect
                }
            }
            return rect
        }
    }
    
    func adjustTitleViewToCenter(){
        
        let index = horizontalView.contentOffset.x.intValue / self.width.intValue
        let cell = self.tableView(titleView, cellForItemAt: index) as! ItemCell
        let rect = cell.titleLabel.convert(cell.titleLabel.bounds, to: self) as CGRect
        let targetCenter = centerX(rect: rect)
        var x = targetCenter - self.width * 0.5
        if x < 0 {
            x = 0
        }
        else {
            let maxX = titleView.contentSize.width - self.width
            if x > maxX {
                x = maxX
            }
        }
        let point = CGPoint(x: x, y: 0)
        titleView.setContentOffset(point, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == horizontalView {
            curIndex = (scrollView.contentOffset.x / self.width).intValue
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
}

fileprivate class ItemCell: QHorizontalTableViewCell {
    var titleLabel: UILabel!
    var cellHeight = 0.f
    var titlePadding = 0.f
    var titleBound: CGRect! {
        didSet{
            updateUI()
        }
    }
    
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
    }
    
    func updateUI(){
        var frame = titleBound as CGRect
        frame.origin.x = titlePadding
        frame.origin.y = (cellHeight - frame.size.height) * 0.5
        titleLabel.frame = frame
    }
}
