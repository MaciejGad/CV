import UIKit
import NibBased

protocol AboutMeRenderable {
    func render(model:AboutMe)
}

enum AboutMeCellProvider:Int, CellType {
    
    case header
    case text
    case links
    
    private func identifier() -> String {
        switch self {
        case .header:
            return AboutMeNameTableViewCell.identifier()
        case .text:
            return AboutMeTextTableViewCell.identifier()
        case .links:
            return LinksTableViewCell.identifier()
        }
    }
    
    static func register(in tableView:UITableView) {
        do {
            try AboutMeNameTableViewCell.registerNib(in: tableView)
            try AboutMeTextTableViewCell.registerNib(in: tableView)
            try LinksTableViewCell.registerNib(in: tableView)
        } catch {
            print("Can't load nib: \(error.localizedDescription)")
        }
    }
    
    func cell(from tableView:UITableView, model:AboutMe, indexPath:IndexPath) -> UITableViewCell {
        let rawCell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath)
        guard let cell = rawCell as? AboutMeRenderable else {
            return rawCell
        }
        cell.render(model: model)
        return rawCell
    }

}
