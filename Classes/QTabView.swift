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

open class QTabView: UIView, QHorizontalTableViewDelegate {
    
    fileprivate var horizontalView: QHorizontalTableView!
    fileprivate var titleView: QHorizontalTableView!
    fileprivate var controller: UIViewController!
    fileprivate lazy var curIndex = 0
    fileprivate lazy var preOrientation = UIDeviceOrientation.unknown
    open var titleFontSize = 17.f
    open var titlePadding = 10.f
    fileprivate lazy var indicator = CALayer()
    open var indicatorHeight = 3.f {
        didSet{
            didSetIndicatorHeight()
        }
    }
    open var indicatorColor = UIColor.brown {
        didSet{
            indicator.backgroundColor = indicatorColor.cgColor
        }
    }
    open var titleNormalColor = UIColor.black
    open var titleSelectedColor = UIColor.brown
    open var titleBackgroundColor = UIColor.white {
        didSet{
            titleView.backgroundColor = titleBackgroundColor
        }
    }
    
    fileprivate var preX = 0.f
    
    open var titles: [String]! {
        didSet{
            didSetTitles()
        }
    }
     
    lazy open var titleBounds = [CGRect]()
    lazy open var titleLabelFrames = [Int : CGRect]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup(){
        
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
        titleView.register(ItemCell.classForCoder(), forCellWithReuseIdentifier: ItemCell.className)
        
        indicator.frame = CGRect(x: 0, y: titleView.height - indicatorHeight, width: 39, height: indicatorHeight)
        indicator.backgroundColor = indicatorColor.cgColor
        self.titleView.layer.addSublayer(indicator)
        
        self.addSubview(titleView)
        self.addSubview(horizontalView)
        
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint(item: titleView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: titleView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: titleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([left, right, top, height])
        horizontalView.layoutInSuperview(50, 0, 0, 0)
        
        horizontalView.register(QHorizontalTableViewCell.classForCoder(), forCellWithReuseIdentifier: QHorizontalTableViewCell.className)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    open func didSetIndicatorHeight(){
        indicator.height = indicatorHeight
        indicator.y = self.titleView.height - indicatorHeight
    }
    
    override open func layoutSubviews() {
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
    
    open func didSetTitles(){
        titleBounds.removeAll()
        titleLabelFrames.removeAll()
        var x = titlePadding
        var i = 0
        for t in titles {
            let bound = t.boundWithSize(CGSize(width: 100, height: titleView.height), font: UIFont.systemFont(ofSize: titleFontSize))
            titleBounds.append(bound)
            
            let frame = CGRect(x: x, y: 0, width: bound.width, height: titleView.height)
            titleLabelFrames[i] = frame
            i += 1
            x += frame.size.width + titlePadding + titlePadding
        }
        titleView.reloadData()
        self.tableView(titleView, didSelectRowAt: curIndex)
    }
    
    open func deviceOrientationDidChanged(){
        
        let device = UIDevice.current
        switch device.orientation {
        case .portrait, .landscapeLeft, .landscapeRight:
            if preOrientation != device.orientation {
                updateTableView()
            }
            preOrientation = device.orientation
            break
        default:
            break
        }

    }
    
    open func updateTableView(){
        
        if self.width + titleView.contentOffset.x > titleView.contentSize.width {
            let px = titleView.contentSize.width - self.width
            titleView.contentOffset = CGPoint(x: px, y: 0)
        }
        
        horizontalView.reloadData()
        if curIndex != -1 {
            self.horizontalView.setContentOffset(CGPoint(x: self.curIndex.f * self.width, y: 0), animated: false)
        }
    }
    
    public func doInMainThreadAfter(_ delay:Double, task:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(delay * 1000)), execute: task)
    }
    
    
    open func tableViewItemsCount(_ tableView: QHorizontalTableView) -> Int {
        
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

    
    open func tableView(_ tableView: QHorizontalTableView, widthForItemAt index: Int) -> CGFloat {
        if tableView == horizontalView {
            return self.width
        }
        else{
            return titleBounds[index].size.width + titlePadding + titlePadding
        }
    }
    
    open func tableView(_ tableView: QHorizontalTableView, cellForItemAt index: Int) -> QHorizontalTableViewCell {
        
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
    
    open func tableView(_ tableView: QHorizontalTableView, didSelectRowAt index: Int) {
        
        if tableView == titleView {
            
            let rect = titleLabelFrames[index]!
            indicator.x = rect.origin.x
            indicator.width = rect.size.width
        
            horizontalView.contentOffset = CGPoint(x: index.f * self.width, y: 0)
            adjustTitleViewToCenter()
        }
    }
    
    open func centerX(rect: CGRect) -> CGFloat {
        return (rect.maxX + rect.minX) * 0.5
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == horizontalView {
            
            // 是否需要调整标题位置居中
            var adjustTitleView = true
            if  titleView.contentSize.width - self.width <= 0 {
                adjustTitleView = false
            }
            let sx = horizontalView.contentOffset.x
            let index = sx.intValue / self.width.intValue
            
            let offset = sx - index.f * self.width
            if offset == 0 {
                return
            }
            let nextIndex = index + 1
            if nextIndex >= titles.count {
                return
            }
            
            let rect0 = titleLabelFrames[index]!
            let rect1 = titleLabelFrames[nextIndex]!
            
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
                
                if adjustTitleView {
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
                
                if adjustTitleView {
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
            }
            
            left += (v0 * t + 0.5 * a0 * t * t) * direct
            right += (v1 * t + 0.5 * a1 * t * t) * direct
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            indicator.x = left
            indicator.width = right - left
            
            if adjustTitleView {
                if px < 0 {
                    px = 0
                }
                else {
                    let maxX = titleView.contentSize.width - self.width
                    if px > maxX && maxX > 0 {
                        px = maxX
                    }
                }
                let point = CGPoint(x: px, y: 0)
                titleView.contentOffset = point
            }
            CATransaction.commit()
            
            preX = sx
        }
    }
    
    open func adjustTitleViewToCenter(){
        
        let index = horizontalView.contentOffset.x.intValue / self.width.intValue
        let rect = titleLabelFrames[index]!
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
        doInMainThreadAfter(0.3) {
            self.curIndex = (self.horizontalView.contentOffset.x / self.width).intValue
            self.titleView.reloadData()
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == horizontalView {
            curIndex = (scrollView.contentOffset.x / self.width).intValue
            titleView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
}

open class ItemCell: QHorizontalTableViewCell {
    
    open var titleLabel: UILabel!
    open var cellHeight = 0.f
    open var titlePadding = 0.f
    open var titleBound: CGRect! {
        didSet{
            updateUI()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup(){
        titleLabel = UILabel(frame: self.frame)
        self.addSubview(titleLabel)
    }
    
    open func updateUI(){
        var frame = titleBound as CGRect
        frame.origin.x = titlePadding
        frame.origin.y = (cellHeight - frame.size.height) * 0.5
        titleLabel.frame = frame
    }
}
