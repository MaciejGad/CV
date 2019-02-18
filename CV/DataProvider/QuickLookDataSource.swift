import UIKit
import QuickLook

protocol QuickLookDataSourceInput:AnyObject {
    init(itemURL:URL)
    var onDismiss:(()->Void)? {get set}
    func previewController() -> UIViewController
}

class QuickLookDataSource:NSObject, QuickLookDataSourceInput, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
    
    let itemURL:URL
    
    var onDismiss:(()->Void)?
    
    required init(itemURL:URL) {
        self.itemURL = itemURL
    }
    
    func previewController() -> UIViewController {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        return previewController
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return itemURL as QLPreviewItem
    }
    
    public func previewControllerDidDismiss(_ controller: QLPreviewController) {
        onDismiss?()
    }
}
