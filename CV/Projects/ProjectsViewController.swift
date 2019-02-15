import UIKit

class ProjectsViewController: TableViewController {

    required init() {
        let promise = DataProvider.default.getProjects()
        let dataSource = ListDataSource<ProjectTableViewCell, Project>(promise: promise, headerTitle: "PREVIOUS PROJECTS")
        super.init(dataSource: dataSource)
    }

}
