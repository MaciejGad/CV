import Foundation

struct AboutMe:Codable {
    let name:String
    let jobTitle:String
    let text:String
    let telephone:String
    let email:String
    let website:String?
    let address:String
    let image:URL?
    let github:URL?
    let pdf:String?
}
