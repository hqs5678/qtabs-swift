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
        self.addSubview(horizontalView)
        
        horizontalView.register(QHorizontalTableViewCell.classForCoder(), forCellWithReuseIdentifier: QHorizontalTableViewCell.className)
    }
    
    
    func tableViewItemsCount(_ tableView: QHorizontalTableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: QHorizontalTableView, didSelectRowAt index: Int) {
        
    }
    
    func tableView(_ tableView: QHorizontalTableView, widthForItemAt index: Int) -> CGFloat {
        return self.width
    }
    
    func tableView(_ tableView: QHorizontalTableView, cellForItemAt index: Int) -> QHorizontalTableViewCell {
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: QHorizontalTableViewCell.className, for: index)
        
        
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func tableView(_ tableView: QHorizontalTableView, willDisplay cell: QHorizontalTableViewCell, forItemAt index: Int) {
        
    }
    
}
