import UIKit
import PromiseKit
import InjectStory

protocol PromiseFetch:AnyObject {
    associatedtype PromiseModel
    var promise:Promise<PromiseModel> {get}
    var data:PromiseModel? {set get}
    var tableView:UITableView? {get}
    
    func fetch()
}


extension PromiseFetch {
    func fetch() {
        promise.done { data in
            self.data = data
            self.tableView?.reloadData()
        }.catch { error in
            PromiseFetchDependency.appRouter.inject().showErrorScreen()
        }
    }
    
}

struct PromiseFetchDependency {
    static let appRouter = Injection<AppRouterInput>(AppDelegate.shared.appRouter)
}
