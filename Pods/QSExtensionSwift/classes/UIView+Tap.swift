 

import UIKit
 
extension UIView {
    
    fileprivate struct AssociatedKeys {
        static var tapHandlePer = "tapHandlePer"
    }
    
    public func addTapWithHandle(_ tapHandle: @escaping (_ tap: UITapGestureRecognizer) -> Void){
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapGestureRecognizerHandle(_:)))
        self.addGestureRecognizer(tap)
        
        let tmpClass = TmpHandleClass()
        tmpClass.tapHandle = tapHandle
        setTapHandle(tmpClass)
    }
    
    public func onTapGestureRecognizerHandle(_ tap: UITapGestureRecognizer){
        
        let tmpClass = objc_getAssociatedObject(self, &AssociatedKeys.tapHandlePer) as? TmpHandleClass
        if tmpClass != nil {
            tmpClass!.tapHandle(tap)
        }
    }
    
    public func setTapHandle(_ tapHandle: TmpHandleClass){
        objc_setAssociatedObject(self, &AssociatedKeys.tapHandlePer, tapHandle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
 }
 
 public class TmpHandleClass {
    
    public var tapHandle: ((_ tap: UITapGestureRecognizer) -> Void)!
 }

