import UIKit

class EmptyViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.main.value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public required init() {
        super.init(nibName:nil, bundle: nil)
        edgesForExtendedLayout = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        edgesForExtendedLayout = []
    }
}
