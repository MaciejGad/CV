import UIKit
import NibBased

class TableViewController: NibBaseViewController {
    
    let dataSource:DataSource
    
    @IBOutlet weak var tableView: UITableView!
    
    init(dataSource:DataSource) {
        self.dataSource = dataSource
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.prepare(tableView: tableView)
        dataSource.fetch()
        view.backgroundColor = Color.main.value
    }
    
     override var isNavigationBarHidden:Bool? {
        return true
    }
    
    override var statusBarLightContent:Bool {
        return true
    }
    
    @available(*, unavailable, message: "don't use init()")
    public required init() {
        fatalError("init() has not been implemented")
    }
}
