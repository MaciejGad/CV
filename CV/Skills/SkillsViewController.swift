import UIKit

class SkillsViewController: TableViewController {
    required init() {
        let promise = DataProvider.default.getSkills()
        let dataSource = ListDataSource<SkillsTableViewCell, Skill>(promise: promise, headerTitle: "SKILLS")
        super.init(dataSource: dataSource)
    }
}
