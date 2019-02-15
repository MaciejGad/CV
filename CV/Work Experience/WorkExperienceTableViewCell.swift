import UIKit
import NibBased

class WorkExperienceTableViewCell: UITableViewCell, Renderable,  LoadFromNib {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var startToEndLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    func render(model: WorkExperience) {
        companyNameLabel.text = model.employerName
        jobTitleLabel.text = model.jobTitle
        descriptionLabel.text = model.description ?? ""
        
        let calendar = Calendar.current
        let startYear:Int = calendar.component(.year, from: model.startDate)
        if let endDate = model.endDate {
            let endYear:Int = calendar.component(.year, from: endDate)
            startToEndLabel.text = "\(startYear)-\(endYear)"
        } else {
            startToEndLabel.text = "\(startYear)-Present"
        }
        let endDate = model.endDate ?? Date()
        let timeIterval = endDate.timeIntervalSince(model.startDate)
        durationLabel.text = timeIterval.toString()
    }
    

    
}


extension TimeInterval {
    func toString() -> String {
        let months = self / TimeInterval.month
        let years = self / TimeInterval.year
        
        guard months > 0 else {
            return ""
        }
        
        switch months {
        case 0..<1.5:
            return "1 month"
        case 1.5..<9:
            return String(format: "%.0f months", months)
        case 9..<15:
            return "1 year"
        case 15..<21:
            return "1.5 years"
        default:
            return String(format: "%.0f years", years)
        }
    }
}
