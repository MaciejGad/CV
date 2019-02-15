import UIKit

extension UIView {
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set(value) {
            layer.cornerRadius = value
            layer.masksToBounds = true
        }
    }
}
