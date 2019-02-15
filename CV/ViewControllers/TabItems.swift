import Foundation
import UIKit
import FontAwesome_swift

enum TabItems:Int, TabItemInput {
    case aboutMe
    case workExperience
    case skills
    case projects
}


extension TabItems {
    func viewController() -> UIViewController {
        switch self {
        case .aboutMe:
            return AboutMeViewController()
        case .workExperience:
            return WorkExperienceViewController()
        case .projects:
            return ProjectsViewController()
        case .skills:
            return SkillsViewController()
        }
    }
    
    func icon() -> UIImage? {
        let iconName:String
        switch self {
        case .aboutMe:
            iconName = "fa-user"
        case .workExperience:
            iconName = "fa-briefcase"
        case .projects:
            iconName = "fa-project-diagram"
        case .skills:
            iconName = "fa-code"
        }
        return UIImage.fontAwesomeIcon(code:iconName , style: .solid, textColor: UIColor.lightGray, size: CGSize(width: 35, height: 35))
    }
    
    func name() -> String {
        switch self {
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
