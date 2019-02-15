import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = createWindow()
        let tabViewController = TabViewController<TabItems>()
        let navigationController = BaseNavigationController(rootViewController: tabViewController)
        window?.rootViewController = navigationController
        return true
    }
}

// MARK:  Internal methods
extension AppDelegate {
    private func createWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        return window
    }
}
