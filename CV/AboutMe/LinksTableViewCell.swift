import UIKit
import NibBased
import InjectStory

class LinksTableViewCell: UITableViewCell, AboutMeRenderable, LoadFromNib {

    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var pdfButton: UIButton!
    
    
    private var phoneNumber:String?
    private var emailAddress:String?
    private var address:String?
    private var github:URL?
    private var pdfURL:URL?
    
    private lazy var appRouter:AppRouterInput = Dependency.appRouter.inject()
    private lazy var documentProvider:DocumentProviderInput = Dependency.documentProvider.inject()
    
    func render(model: AboutMe) {
        phoneNumber = model.telephone
        emailAddress = model.email
        address = model.address
        phoneButton.setTitle(model.telephone, for: .normal)
        emailButton.setTitle(model.email, for: .normal)
        addressButton.setTitle(model.address, for: .normal)
        if let github = model.github {
            githubButton.superview?.isHidden = false
            githubButton.setTitle(github.shortUrl(), for: .normal)
            self.github = github
        } else {
            githubButton.superview?.isHidden = true
            github = nil
        }
        pdfURL = nil
        
        if let pdfName = model.pdf {
            if let pdfURL = documentProvider.resolve(filename: pdfName, withExtension: "pdf") {
                pdfButton.superview?.isHidden = false
                pdfButton.setTitle(pdfName + ".pdf", for: .normal)
                self.pdfURL = pdfURL
            } else {
                pdfButton.superview?.isHidden = true
            }
        } else {
            pdfButton.superview?.isHidden = true
        }
       
    }

    
    @IBAction func phoneAction() {
        guard let phoneNumber = phoneNumber else {
            return
        }
        guard let url = phoneNumber.phoneNumber() else {
            return
        }
        appRouter.open(url: url)
    }
    
    @IBAction func emailAction() {
        guard let emailAddress = emailAddress else {
            return
        }
        guard let url = URL(string: "mailto:\(emailAddress)") else {
            return
        }
        appRouter.open(url: url)
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
        appRouter.open(url: url)
    }
    
    @IBAction func openGithub() {
        guard let github = github else {
            return
        }
        appRouter.open(url: github)
    }
    
    @IBAction func openPdfPreview() {
        guard let pdfURL = self.pdfURL else {
            return
        }
        appRouter.preview(url: pdfURL)
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


extension LinksTableViewCell {
    struct Dependency {
        static let appRouter = Injection<AppRouterInput>(AppDelegate.shared.appRouter)
        static let documentProvider = Injection<DocumentProviderInput>(DocumentProvider())
    }
}


extension URL {
    func shortUrl() -> String {
        let host = self.host ?? ""
        return host+path
    }
}
