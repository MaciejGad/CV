import Foundation

struct Project:Codable {
    let name:String
    let time:TimeInterval
    let role:String
    let technologies:[String]
    let note:String
    let link:URL?
}


extension TimeInterval {
    static var minute:TimeInterval = 60
    static var hour:TimeInterval = 60 * TimeInterval.minute
    static var day:TimeInterval = 24 * TimeInterval.hour
    static var week:TimeInterval = 5 * TimeInterval.day
    static var month:TimeInterval = TimeInterval.year / 12
    static var year:TimeInterval = 365.25 * TimeInterval.day
}
