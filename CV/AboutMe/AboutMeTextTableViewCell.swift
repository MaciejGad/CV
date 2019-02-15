import UIKit
import NibBased

class AboutMeTextTableViewCell: UITableViewCell, AboutMeRenderable, LoadFromNib {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var aboutMeTextLabel: UILabel!
    
    func render(model: AboutMe) {
        aboutMeTextLabel.text = model.text
        headerLabel.textColor = Color.main.value
        headerLabel.text = "ABOUT ME"
    }
    
}
