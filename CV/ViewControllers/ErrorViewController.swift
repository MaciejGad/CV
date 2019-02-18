import UIKit
import NibBased
import InjectStory

class ErrorViewController: NibBaseViewController {
    
    let bundle = Dependency.bundle.inject()
    private lazy var appRouter:AppRouterInput = Dependency.appRouter.inject()
    
    @IBOutlet var openWebsiteButton:UIButton!
    
    private let websiteNameKey = "websiteName"
    private let websiteLinkKey = "websiteLink"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let websiteName = bundle.string(forInfoDictionaryKey: websiteNameKey) {
            openWebsiteButton.setTitle(websiteName, for: .normal)
        }
    }
    
    override var isNavigationBarHidden:Bool? {
        return true
    }
    
    override var statusBarLightContent:Bool {
        return false
    }
    
    @IBAction func openWebsiteAction() {
        guard let link = bundle.string(forInfoDictionaryKey: websiteLinkKey) else {
            return
        }
        guard let url = URL(string: link) else {
            return
        }
        appRouter.open(url: url)
    }
}

extension ErrorViewController {
    struct Dependency {
        static let bundle = Injection<Bundle>(Bundle.main)
        static let appRouter = Injection<AppRouterInput>(AppDelegate.shared.appRouter)
    }
}

extension Bundle {
    func string(forInfoDictionaryKey key: String) -> String? {
        return object(forInfoDictionaryKey: key) as? String
    }
}
