import Foundation

struct WorkExperience: Codable {
    let startDate:Date
    let endDate:Date? //nil means - Present
    let employerName:String
    let jobTitle:String
    let description:String?
}
