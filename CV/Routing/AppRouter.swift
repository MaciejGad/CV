import UIKit
import InjectStory

protocol AppRouterInput {
    func rootViewController() -> UIViewController
    func showTabs()
    func showLunchScreen()
    func showErrorScreen()
    func showEmptyScreen()
    func open(url:URL)
    func preview(url:URL)
}

class AppRouter:AppRouterInput {
    
    let tabCreator:TabCreatorInput = Dependency.tabCreator.inject()
    let navigationController:UINavigationController = BaseNavigationController()
    
    var quickLookDataSource:QuickLookDataSourceInput?
    
    func rootViewController() -> UIViewController {
        return navigationController
    }
    
    func showTabs() {
        let tabViewController = TabViewController()
        tabViewController.viewControllers = tabCreator.tabViewControllers()
        navigationController.setViewControllers([tabViewController], animated: true)
    }
    
    func showLunchScreen() {
        let startScreen = LaunchViewController()
        navigationController.setViewControllers([startScreen], animated: false)
    }
   
    func showErrorScreen() {
        let errorScreen = ErrorViewController()
        navigationController.setViewControllers([errorScreen], animated: true)
    }
    
    func showEmptyScreen() {
        let emptyScreen = EmptyViewController()
        navigationController.setViewControllers([emptyScreen], animated: false)
    }
    
    func preview(url:URL) {
        let quickLookDataSource = Dependency.quickLookDataSource.inject(argument: url)
        quickLookDataSource.onDismiss = {[weak self] in
            self?.quickLookDataSource = nil
        }
        let previewController = quickLookDataSource.previewController()
        previewController.view.tintColor = Color.main.value
        navigationController.present(previewController, animated: true, completion: nil)
        self.quickLookDataSource = quickLookDataSource
    }
    
    func open(url:URL) {
        let application = UIApplication.shared
        guard application.canOpenURL(url) else {
            return
        }
        application.open(url, options: [:], completionHandler: nil)
    }
}
extension AppRouter {
    struct Dependency {
        static let tabCreator = Injection<TabCreatorInput>(TabCreator())
        static let quickLookDataSource = ArgumentedInjection<QuickLookDataSourceInput, URL> {
            return QuickLookDataSource(itemURL: $0)
        }
    }
}
