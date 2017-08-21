//
//  QHorizontalTableView.swift
//  horizontaltableview
//
//  Created by 火星人 on 2017/6/24.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit


open class QHorizontalTableView: UICollectionView {
    

    weak public var tableViewDelegate: QHorizontalTableViewDelegate! {
        didSet{
            viewLayout.delegate = tableViewDelegate
        }
    }
    
    public var viewLayout: LinearLayout!
    
    // 使用缓存在table view 内容比较少时可以提高性能, 内容多时可能会占用内存过多, 酌情使用
    public var useCacheForViewLayout = false {
        didSet{
            if let viewLayout = viewLayout {
                viewLayout.useCache = useCacheForViewLayout
            }
        }
    }
    
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
        
        viewLayout.scrollDirection = .horizontal
        viewLayout.minimumLineSpacing = 0
        viewLayout.minimumInteritemSpacing = 0
        viewLayout.headerReferenceSize = CGSize.zero
        viewLayout.footerReferenceSize = CGSize.zero
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        viewLayout.tableView = self
        self.collectionViewLayout = viewLayout
        
        self.dataSource = self
        self.delegate = self
        
    }
    
    public func dequeueReusableCell(withReuseIdentifier identifier: String, for index: Int) -> QHorizontalTableViewCell {
        let indexPath = IndexPath(row: index, section: 0)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! QHorizontalTableViewCell
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
        tableViewDelegate.tableView(self, didSelectRowAt: indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        tableViewDelegate.tableView(self, willDisplay: cell as! QHorizontalTableViewCell, forItemAt: indexPath.row)
    }
    
}

open class LinearLayout: UICollectionViewFlowLayout {
    
    weak var delegate: QHorizontalTableViewDelegate!
    weak var tableView: QHorizontalTableView!
    var useCache = false
    
    // 优化性能
    fileprivate lazy var attrs = [String : [UICollectionViewLayoutAttributes]]()
    
    public override init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if useCache, let array = attrs["\(rect)"] {
            return array
        }
        else{
            let array = super.layoutAttributesForElements(in: rect)
            attrs["\(rect)"] = array
            return array
        }
        
    }
    
    open override var collectionViewContentSize: CGSize {
        let size = super.collectionViewContentSize
        if size.width <= tableView.frame.size.width {
            return CGSize(width: tableView.frame.size.width + 0.5, height: size.height)
        }
        else{
            return size
        }
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

open class QHorizontalTableViewCell: UICollectionViewCell {
    
}

public protocol QHorizontalTableViewDelegate: NSObjectProtocol {
    
    func tableViewItemsCount(_ tableView: QHorizontalTableView) -> Int
    
    func tableView(_ tableView: QHorizontalTableView, cellForItemAt index: Int) -> QHorizontalTableViewCell
    
    func tableView(_ tableView: QHorizontalTableView, widthForItemAt index: Int) -> CGFloat
    
    func tableView(_ tableView: QHorizontalTableView, didSelectRowAt index: Int)
    
    func tableView(_ tableView: QHorizontalTableView, willDisplay cell: QHorizontalTableViewCell, forItemAt index: Int)
    
}
