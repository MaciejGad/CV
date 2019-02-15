import Foundation

struct Education:Codable {
    let schoolName:String
    let startDate:Date
    let endDate:Date? //nil mean present
    let description:String 
}
