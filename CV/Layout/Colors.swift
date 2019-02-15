import Foundation
import UIKit


public enum Color:String {
    case main
    case background
    case text
    
    public var value:UIColor {
        return Color.colorValues[self] ?? .black
    }
    
    private static var colorValues:[Color:UIColor] = [
        .main: #colorLiteral(red: 0, green: 0.6823529412, blue: 0.937254902, alpha: 1),
        .background: .white,
        .text: .darkText
    ]
    
    public static func set(value:UIColor, for color:Color) {
        colorValues[color] = value
    }
}


extension UILabel {
    @IBInspectable var mainTextColor:Bool {
        get {
            return false
        }
        set(value) {
            if value {
                textColor = Color.main.value
            }
        }
    }
}


extension UIView {
    @IBInspectable var mainBackgroundColor:Bool {
        get {
            return false
        }
        set(value) {
            if value {
                backgroundColor = Color.main.value
            }
        }
    }
}
