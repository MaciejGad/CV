import UIKit
import NibBased

class LaunchViewController: NibBaseViewController {
    override var isNavigationBarHidden:Bool? {
        return true
    }
    
    override var statusBarLightContent:Bool {
        return false
    }
}
