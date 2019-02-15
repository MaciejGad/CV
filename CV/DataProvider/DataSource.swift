import UIKit

protocol DataSource:UITableViewDataSource, UITableViewDelegate {
    func fetch()
    func prepare(tableView:UITableView)
    func registerCells(in tableView:UITableView)
    
    var tableView:UITableView? {set get}
}

extension DataSource {
    func prepare(tableView:UITableView) {
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
        registerCells(in: tableView)
    }
}

