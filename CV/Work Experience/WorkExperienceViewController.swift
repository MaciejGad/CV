import UIKit

class WorkExperienceViewController: TableViewController {
    required init() {
        let promise = DataProvider.default.getWorkExperience()
        let dataSource = ListDataSource<WorkExperienceTableViewCell, WorkExperience>(promise: promise, headerTitle: "WORK EXPERIENCE")
        super.init(dataSource: dataSource)
    }
    
}
