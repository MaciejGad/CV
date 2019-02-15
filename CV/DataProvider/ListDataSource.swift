import UIKit
import NibBased
import PromiseKit

protocol Renderable {
    associatedtype Model
    func render(model:Model)
}

class ListDataSource<Cell:Renderable, Item>:NSObject, DataSource, PromiseFetch where Cell:UITableViewCell, Cell.Model == Item {
    
    let headerTitle:String
    
    let promise:Promise<[Item]>
    var data:[Item]? = nil
    var tableView:UITableView?
    
    init(promise:Promise<[Item]>, headerTitle:String) {
        self.promise = promise
        self.headerTitle = headerTitle
    }
    
    func registerCells(in tableView: UITableView) {
        do {
            try Cell.registerNib(in: tableView)
        } catch  {
            print(error.localizedDescription)
        }
        setupHeader()
    }
    
    func setupHeader() {
        guard let tableView = tableView else {
            return
        }
        guard let header = try? TitleHeader.loadFromNib() else {
            return
        }
        header.titleLabel.text = headerTitle
        tableView.tableHeaderView = header
        header.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1).isActive = true
        header.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        header.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = data?[safe: indexPath.row] else {
            return UITableViewCell()
        }
        let rawCell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier(), for: indexPath)
        guard let cell = rawCell as? Cell else {
            return rawCell
        }
        cell.render(model: item)
        return cell
    }
    
    
}
