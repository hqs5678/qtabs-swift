 

import UIKit
  

extension UIView {
    
    // MARK: self.frame.origin.x
    public var x: CGFloat {
        
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    // MARK: self.frame.origin.y
    public var y: CGFloat {
        
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    // MARK: self.frame.origin
    public var origin: CGPoint {
        
        set(newValue) {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    // MARK: self.frame.size.width
    public var width: CGFloat {
        
        set(newValue) {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    // MARK: self.frame.size.height
    public var height: CGFloat {
        
        set(newValue) {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    // MARK: self.frame.size
    public var size: CGSize {
        
        set(newValue) {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    // MARK: 最大的y值  即self的最下面的y 值
    public var maxY: CGFloat {
        let frame = self.frame
        return frame.maxY
    }
    
    // MARK: 最大的x值  即self的最右边的x 的值
    public var maxX: CGFloat {
        let frame = self.frame
        return frame.maxX
    }
    
    // MARK: 当self 在view中居中显示时的 originX
    public func centerXInView(_ view: UIView) -> CGFloat{
        
        let x = (view.width - self.width) * 0.5
        return x
    }
    
    // MARK: 当self 在view中居中显示时的 originY
    public func centerYInView(_ view: UIView) -> CGFloat{
        
        let y = (view.height - self.height) * 0.5
        return y
    }
    
    // MARK: 设置self 在view中居中
    public func centerInView(_ view: UIView) {
        
        let x = centerXInView(view)
        let y = centerYInView(view)
        
        var frame = self.frame
        frame.origin.x = x
        frame.origin.y = y
        self.frame = frame
    }
    
    // MARK: 设置self 在view中居中
    public func centerInSuperView() {
        if let view = self.superview {
            centerInView(view)
        }
    }
    
 
 }

