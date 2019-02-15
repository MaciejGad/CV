import UIKit
import NibBased

class LinksTableViewCell: UITableViewCell, AboutMeRenderable, LoadFromNib {

    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    
    private var phoneNumber:String?
    private var emailAddress:String?
    private var address:String?
    
    func render(model: AboutMe) {
        phoneNumber = model.telephone
        emailAddress = model.email
        address = model.address
        phoneButton.setTitle(model.telephone, for: .normal)
        emailButton.setTitle(model.email, for: .normal)
        addressButton.setTitle(model.address, for: .normal)
    }
    
    @IBAction func phoneAction() {
        guard let phoneNumber = phoneNumber else {
            return
        }
        guard let url = phoneNumber.phoneNumber() else {
            return
        }
        UIApplication.open(url: url)
    }
    
    @IBAction func emailAction() {
        guard let emailAddress = emailAddress else {
            return
        }
        guard let url = URL(string: "mailto:\(emailAddress)") else {
            return
        }
        UIApplication.open(url: url)
    }
    @IBAction func addressAction() {
        guard let address = address else {
            return
        }
        guard let query = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let url = URL(string: "http://maps.apple.com/?address=\(query)") else {
            return
        }
        UIApplication.open(url: url)
    }
}


extension String {
    func phoneNumber() -> URL? {
        let numbers:[Character] = (0..<10).map { Character("\($0)")}
        let numbersSet = Set<Character>(numbers)
        let numberOnly = self.filter { numbersSet.contains($0) }
        return URL(string: "tel://\(numberOnly)")
    }
}

extension UIApplication {
    static func open(url:URL) {
        let application = UIApplication.shared
        guard application.canOpenURL(url) else {
            return
        }
        application.open(url, options: [:], completionHandler: nil)
    }
}
