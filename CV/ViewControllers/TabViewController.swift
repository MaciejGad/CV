import UIKit

protocol TabItemInput:Equatable, CaseIterable {
    func viewController() -> UIViewController
    func icon() -> UIImage?
    func name() -> String
}

class TabViewController: UITabBarController {
    let tabDelegate = Delegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = tabDelegate
        tabBar.tintColor = Color.main.value
        tabBar.barTintColor = Color.background.value
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.isTranslucent = false
        tabBar.itemPositioning = .fill
 
    }
}

extension TabViewController {
    class Delegate:NSObject, UITabBarControllerDelegate {
        func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            
            guard let selectedViewController = tabBarController.selectedViewController else {
                return true
            }
            if viewController == selectedViewController {
                viewController.viewWillAppear(true)
                viewController.viewDidAppear(true)
            }
            return true
        }
    }
}


extension UIDevice {
    var isIpad:Bool {
        return userInterfaceIdiom == .pad
    }
    var notIpad:Bool {
        return !isIpad
    }
}
