import Foundation
import UIKit

public class BaseNavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
        
        navigationBar.backgroundColor = Color.background.value
        navigationBar.tintColor = Color.main.value
    }
    
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? .default
    }
}
