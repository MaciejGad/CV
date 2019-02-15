import UIKit
import NibBased

class SkillsTableViewCell: UITableViewCell, Renderable, LoadFromNib {

    @IBOutlet weak var skillsTitleLabel: UILabel!
    @IBOutlet weak var skillListLabel: UILabel!
    
    func render(model: Skill) {
        skillsTitleLabel.text = "\(model.title):"
        skillListLabel.text = model.values.joined(separator: ", ")
    }
    
}
