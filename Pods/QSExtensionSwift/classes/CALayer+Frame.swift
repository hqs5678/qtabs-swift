 

import UIKit
  

extension CALayer {
    
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
    
    // MARK: 当self 在Layer中居中显示时的 originX
    public func centerXInLayer(_ layer: CALayer) -> CGFloat{
        
        let x = (layer.width - self.width) * 0.5
        return x
    }
    
    // MARK: 当self 在Layer中居中显示时的 originY
    public func centerYInLayer(_ layer: CALayer) -> CGFloat{
        
        let y = (layer.height - self.height) * 0.5
        return y
    }
    
    // MARK: 设置self 在Layer中居中
    public func centerInLayer(_ layer: CALayer) {
        
        let x = centerXInLayer(layer)
        let y = centerYInLayer(layer)
        
        var frame = self.frame
        frame.origin.x = x
        frame.origin.y = y
        self.frame = frame
    }
    
    // MARK: 设置self 在Layer中居中
    public func centerInSuperLayer() {
        if let layer = self.superlayer {
            centerInLayer(layer)
        }
    }
    
    // MARK: 在superlayer 中置顶
    public func topInSuperLayer() {
        self.y = 0
    }
    
    // MARK: 在superlayer 中置底
    public func bottomInSuperLayer() {
        if let layer = self.superlayer {
            self.y = layer.height - self.height
        }
    }
 }

