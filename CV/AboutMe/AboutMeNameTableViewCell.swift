import UIKit
import NibBased

class AboutMeNameTableViewCell: UITableViewCell, AboutMeRenderable, LoadFromNib {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!

    func render(model: AboutMe) {
        nameLabel.text = model.name
        jobTitleLabel.text = model.jobTitle
        contentView.backgroundColor = Color.main.value
    }
    
}
