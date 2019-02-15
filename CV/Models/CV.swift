import Foundation

struct CV:Codable {
    let aboutMe:AboutMe
    let workExperience:[WorkExperience]
    let education:[Education]
    let skills:[Skill]
    let projects:[Project]
}
