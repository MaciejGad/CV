import UIKit
import NibBased

class TableViewController: NibBaseViewController {
    
    let dataSource:DataSource
    
    init(dataSource:DataSource) {
        self.dataSource = dataSource
        super.init()
    }
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.prepare(tableView: tableView)
        dataSource.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var isNavigationBarHidden:Bool? {
        return true
    }
    
    override var statusBarLightContent:Bool {
        return false
    }
    
    public required init() {
        fatalError("init() has not been implemented")
    }
}
