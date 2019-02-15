import UIKit

class AboutMeViewController: TableViewController {
    
    required init() {
        let promise = DataProvider.default.getAboutMe()
        let dataSource = StaticDataSource<AboutMe, AboutMeCellProvider>(promise: promise)
        super.init(dataSource: dataSource)
    }
    
}
