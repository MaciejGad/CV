import UIKit
import FontAwesome_swift
import InjectStory

protocol TabCreatorInput {
    func tabViewControllers() -> [UIViewController]
}

class TabCreator: TabCreatorInput {
    let dataProvider = Dependency.dataProvider.inject()
    
    func tabViewControllers() -> [UIViewController] {
        return TabItem.allCases.map{
            let vc = self.viewController(for: $0)
            let icon = self.icon(for: $0)
            vc.tabBarItem.image = icon?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.selectedImage = icon
            vc.tabBarItem.title = self.name(for: $0)
            return vc
        }
    }
    
    private func viewController(for tab:TabItem) -> UIViewController {
        let dataSource:DataSource
        switch tab {
        case .aboutMe:
            dataSource = StaticDataSource<AboutMe, AboutMeCellProvider>(promise:  dataProvider.getAboutMe())
        case .workExperience:
            dataSource = ListDataSource<WorkExperienceTableViewCell, WorkExperience>(promise: dataProvider.getWorkExperience(), headerTitle: "WORK EXPERIENCE")
        case .projects:
            dataSource = ListDataSource<ProjectTableViewCell, Project>(promise: dataProvider.getProjects(), headerTitle: "PREVIOUS PROJECTS")
        case .skills:
            dataSource = ListDataSource<SkillsTableViewCell, Skill>(promise: dataProvider.getSkills(), headerTitle: "SKILLS")
        }
        return TableViewController(dataSource: dataSource)
    }
    
    private func icon(for tab:TabItem) -> UIImage? {
        let iconName:String
        switch tab {
        case .aboutMe:
            iconName = "fa-user"
        case .workExperience:
            iconName = "fa-briefcase"
        case .projects:
            iconName = "fa-project-diagram"
        case .skills:
            iconName = "fa-code"
        }
        return UIImage.fontAwesomeIcon(code:iconName , style: .solid, textColor: UIColor.lightGray, size: CGSize(width: 35, height: 35))?.withRenderingMode(.alwaysTemplate)
    }
    
    private func name(for tab:TabItem) -> String {
        switch tab {
        case .aboutMe:
            return "About me"
        case .workExperience:
            return "Work Experience"
        case .projects:
            return "Projects"
        case .skills:
            return "Skills"
        }
    }
}

extension TabCreator {
    struct Dependency {
        static let dataProvider = Injection<DataProviderInput>(DataProvider.default)
    }
}
