import Foundation
import UIKit


public enum Color:String {
    case main
    case border
    case background
    case text
    
    public var value:UIColor {
        return Color.colorValues[self] ?? .black
    }
    
    private static var colorValues:[Color:UIColor] = [
        .main: #colorLiteral(red: 0, green: 0.5333333333, blue: 0.8078431373, alpha: 1), // #colorLiteral(red: 0, green: 0.6823529412, blue: 0.937254902, alpha: 1),
        .border: #colorLiteral(red: 0.007843137255, green: 0.3294117647, blue: 0.6509803922, alpha: 1),
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
