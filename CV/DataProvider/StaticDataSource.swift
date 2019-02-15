import UIKit
import PromiseKit

protocol CellType:CaseIterable {
    associatedtype Model
    init?(rawValue:Int)
    static func register(in tableView:UITableView)
    func cell(from tableView:UITableView, model:Model, indexPath:IndexPath) -> UITableViewCell
}

class StaticDataSource<Item, CellProvider:CellType>:NSObject, DataSource, PromiseFetch where CellProvider.Model == Item {

    let promise:Promise<Item>
    var data:Item? = nil
    var tableView:UITableView?
    
    init(promise:Promise<Item>) {
        self.promise = promise
    }
    
    func registerCells(in tableView: UITableView) {
        CellProvider.register(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = data else {
            return 0
        }
        return CellProvider.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = data else {
            return UITableViewCell()
        }
        guard let cellType = CellProvider(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        return cellType.cell(from: tableView, model: model, indexPath: indexPath)
    }
    

}
