import UIKit

extension UIView {
    
    @IBInspectable var borderWidth:CGFloat {
        get {
            return layer.borderWidth
        }
        
        set(value) {
            layer.borderWidth = value
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
        get {
            guard let rawColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: rawColor)
        }
        
        set(value) {
            guard let value = value else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = value.cgColor
        }
    }
    
    
    
    func border(color:UIColor) {
        borderWidth = 1
        borderColor = color
    }
    
}
