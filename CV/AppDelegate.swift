import UIKit
import InjectStory
import PromiseKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appRouter:AppRouterInput = Dependency.appRouter.inject()
    let dataProvider:DataProviderInput = Dependency.dataProvider.inject()
    let testInfo:TestInfo = Dependency.testInfo.inject()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = createWindow()
        window?.rootViewController = appRouter.rootViewController()
        guard !testInfo.isRunningTests() else {
            appRouter.showEmptyScreen()
            return true
        }
        loadData()
        return true
    }
    
    func loadData() {
        appRouter.showLunchScreen()
        dataProvider.preloadData().done {
            self.appRouter.showTabs()
        }.catch { _ in 
            self.appRouter.showErrorScreen()
        }
    }
}

extension AppDelegate {
    struct Dependency {
        static let appRouter = Injection<AppRouterInput>(AppRouter())
        static let dataProvider = Injection<DataProviderInput>(DataProvider.default)
        static let testInfo = Injection<TestInfo>(ProcessInfo.processInfo)
    }
}

// MARK: shared instance
extension AppDelegate {
    class var shared: AppDelegate {
        get {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                return AppDelegate()
            }
            return delegate
        }
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
