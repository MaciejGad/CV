import XCTest
@testable import CV

class DataTests: XCTestCase {


    func testGenerateJSON() throws {
        //given
        let cv = createCV()
        let encoder = JSONEncoder()
        let givenData = getData(name: "cv")

        //when
        let data = try encoder.encode(cv)
//        try data.save(to: "cv")
        
        //then
        XCTAssertEqual(data, givenData)
    }

    
    func createCV() -> CV {
        let aboutMe = AboutMe(name: "Maciej Gad", jobTitle: "Senior iOS Developer", text: "I love mobile and I always have my iPhone nearby ;) I'm an iOS Programmer with almost 8 years of experience in mobile solutions for business. Since 2011, I created over 20 unique, custom apps both as an individual Developer and as a part of bigger teams. For the last 4 years, I was primarily working remotely with clients from UK & UAE.", telephone: "+48 535471 696", email: "gad.maciej@gmail.com", website: "http://maciejgad.pl", address: "27/31 Magellana St.\nWrocław, Poland", image: "http://maciejgad.pl/avatar.jpg", background: nil)
        let workExperience:[WorkExperience] = [
            WorkExperience(startDate: Date(timeIntervalSince1970: 1280656800.0), endDate: Date(timeIntervalSince1970: 1338458400.0), employerName: "Artweb Media", jobTitle: "Administrator / web developer", description: nil)
        ]
        let education:[Education] = [
            Education(schoolName: "Wroclaw University of Science and Technology", startDate: Date(timeIntervalSince1970: 1159693200.0), endDate: Date(timeIntervalSince1970: 1331118000.0) , description: "Master of Science - MS, Bioinformatics")
        ]
        let skills:[Skill] = [
            Skill(title: "Programming languages", values: ["Swift", "Objective-C","Python"])
        ]
        let projects:[Project] = [
            Project(name: "Staff Management App", time: 19 * TimeInterval.month, role: "iOS Developer", technologies: ["Swift", "Firebase", "Push Notifications", "oAuth2", "PromiseKit", "Unit Tests", "UI Tests"], note: "Staff Management App for UK-based company, about 60% of unit test code coverage, extended UI integration tests")
        ]
        return CV(aboutMe: aboutMe, workExperience: workExperience, education: education, skills: skills, projects: projects)
    }
}


extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StaticString) {
        self = URL(string: "\(value)")!
    }
    
}

extension XCTestCase {
    func getData(name:String, withExtension:String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: url!)
        return data
    }
}

extension Data {
    func save(to file:String) throws {
        let documentDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDir.appendingPathComponent(file).appendingPathExtension("json")
        print(fileURL)
        try write(to: fileURL)
    }
}
