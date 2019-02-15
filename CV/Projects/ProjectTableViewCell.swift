import UIKit
import NibBased

class ProjectTableViewCell: UITableViewCell, Renderable, LoadFromNib {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var technologiesLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet var linkElements: [UIView]!
    @IBOutlet weak var openInAppStore: UIButton!
    private var link:URL?
    
    func render(model: Project) {
        nameLabel.text = model.name
        timeLabel.text = model.time.toString()
        roleLabel.text = model.role
        technologiesLabel.text = model.technologies.joined(separator: ", ")
        noteLabel.text = model.note
        if let link = model.link {
            linkElements.forEach { view in
                view.isHidden = false
            }
            self.link = link
            if link.absoluteString.contains("itunes.apple.com") {
                openInAppStore.setTitle("Open in AppStore", for: .normal)
            } else if link.absoluteString.contains("github.com") {
                openInAppStore.setTitle("Checkout source from GitHub", for: .normal)
            } else {
                openInAppStore.setTitle("Open in Safari", for: .normal)
            }
            openInAppStore.setTitleColor(Color.main.value, for: .normal)
        } else {
            linkElements.forEach { view in
                view.isHidden = true
            }
        }
        
    
    }
    
    @IBAction func linkAction() {
        guard let link = link else {
            return
        }
        UIApplication.open(url: link)
    }
    
}
