//
//  QHorizontalTableView.swift
//  horizontaltableview
//
//  Created by 火星人 on 2017/6/24.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit


open class QHorizontalTableView: UICollectionView {
    
    
    fileprivate var preOrientation = UIDeviceOrientation.unknown
    fileprivate var contentOffsetX = 0.f
    
    weak public var tableViewDelegate: QHorizontalTableViewDelegate! {
        didSet{
            viewLayout.delegate = tableViewDelegate
        }
    }
    
    public var viewLayout: LinearLayout!
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.viewLayout = layout as? LinearLayout
        setup()
    }
    
    public convenience init(frame: CGRect) {
        self.init(frame: frame, collectionViewLayout: LinearLayout())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    open func setup(){
        
        if viewLayout == nil {
            viewLayout = LinearLayout()
        }
        
        viewLayout.tableView = self
        self.collectionViewLayout = viewLayout
        
        self.dataSource = self
        self.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        self.addObserver(self, forKeyPath: "contentInset", options: [.new, .old], context: nil)
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
        self.contentOffset = CGPoint(x: self.contentOffsetX, y: 0)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        contentOffsetX = self.contentOffset.x
        if self.contentInset != UIEdgeInsets.zero {
            self.contentInset = UIEdgeInsets()
        }
    }
    
    public func dequeueReusableCell(withReuseIdentifier identifier: String, for index: Int) -> QHorizontalTableViewCell {
        let indexPath = IndexPath(row: index, section: 0)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! QHorizontalTableViewCell
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "contentInset")
        NotificationCenter.default.removeObserver(self)
    }
    
}

// delegate
extension QHorizontalTableView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let tableViewDelegate = tableViewDelegate {
            return tableViewDelegate.tableViewItemsCount(self)
        }
        else{
            return 0
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.tableViewDelegate.tableView(self, cellForItemAt: indexPath.row)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: IndexPath!) -> CGSize{
        
        return CGSize(width: tableViewDelegate.tableView(self, widthForItemAt: indexPath.row), height: self.frame.size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tableViewDelegate.tableView?(self, didSelectRowAt: indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        tableViewDelegate.tableView?(self, willDisplay: cell as! QHorizontalTableViewCell, forItemAt: indexPath.row)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableViewDelegate = tableViewDelegate {
            tableViewDelegate.scrollViewDidScroll?(scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let tableViewDelegate = tableViewDelegate {
            tableViewDelegate.scrollViewDidEndDecelerating?(scrollView)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let tableViewDelegate = tableViewDelegate {
            tableViewDelegate.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        }
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        if let tableViewDelegate = tableViewDelegate {
            tableViewDelegate.scrollViewDidScrollToTop?(scrollView)
        }
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if let tableViewDelegate = tableViewDelegate {
            tableViewDelegate.scrollViewWillBeginDecelerating?(scrollView)
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let tableViewDelegate = tableViewDelegate {
            tableViewDelegate.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
}

open class LinearLayout: UICollectionViewLayout {
    
    weak var delegate: QHorizontalTableViewDelegate!
    weak var tableView: QHorizontalTableView!
      
    private lazy var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private lazy var w = 0.f
    private lazy var h = 0.f
    private lazy var contentSizeW = 0.f
    
    override open func prepare() {
        
        if layoutAttributes.count == 0 {
            
            w = self.tableView.frame.size.width
            h = self.tableView.frame.size.height
            
            if let collectionView = self.collectionView {
                let number = collectionView.numberOfItems(inSection: 0)
                var x = 0.f
                var cellW = 0.f
                for i in 0 ..< number {
                    
                    cellW = delegate.tableView(tableView, widthForItemAt: i)
                    
                    let indexPath = IndexPath(row: i, section: 0)
                    let attr = layoutAttributesForItem(at: indexPath)
                    attr?.frame = CGRect(x: x, y: 0, width: cellW, height: h)
                    
                    layoutAttributes.append(attr!)
                    
                    x += cellW
                }
                contentSizeW = x
            }
        }
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        return attr
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override open var collectionViewContentSize: CGSize {
        
        return CGSize(width: contentSizeW, height: h)
    }

    
}

open class QHorizontalTableViewCell: UICollectionViewCell {
    
}

@objc public protocol QHorizontalTableViewDelegate: NSObjectProtocol {
    
    func tableViewItemsCount(_ tableView: QHorizontalTableView) -> Int
    
    func tableView(_ tableView: QHorizontalTableView, cellForItemAt index: Int) -> QHorizontalTableViewCell
    
    func tableView(_ tableView: QHorizontalTableView, widthForItemAt index: Int) -> CGFloat
    
    @objc optional func tableView(_ tableView: QHorizontalTableView, didSelectRowAt index: Int)
    
    @objc optional func tableView(_ tableView: QHorizontalTableView, willDisplay cell: QHorizontalTableViewCell, forItemAt index: Int)
    
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
    
    @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    
    @objc optional func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    
    @objc optional func scrollViewDidScrollToTop(_ scrollView: UIScrollView)
    
    @objc optional func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    
    @objc optional func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

extension Int {
    var f: CGFloat {
        return CGFloat(self)
    }
}
