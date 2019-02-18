import Foundation
import PromiseKit
import InjectStory

protocol DataProviderInput {
    func getAboutMe() -> Promise<AboutMe>
    func getWorkExperience() -> Promise<[WorkExperience]>
    func getEducation() -> Promise<[Education]>
    func getSkills() -> Promise<[Skill]>
    func getProjects() -> Promise<[Project]>
    
    func preloadData() -> Promise<Void>
}

class DataProvider:DataProviderInput {
    
    static var `default` = DataProvider()
    
    private let bundle:Bundle = Dependency.bundle.inject()
    private let loadingQueue:DispatchQueue = Dependency.loadingQueue.inject()
    
    lazy var cv:Promise<CV> = self.getCV()
    
    func getAboutMe() -> Promise<AboutMe> {
        
        return cv.then { cv -> Promise<AboutMe> in
            return .value(cv.aboutMe)
        }
    }
    
    func getWorkExperience() -> Promise<[WorkExperience]> {
        return cv.then { cv -> Promise<[WorkExperience]> in
            return .value(cv.workExperience)
        }
    }
    
    func getEducation() -> Promise<[Education]> {
        return cv.then { cv -> Promise<[Education]> in
            return .value(cv.education)
        }
    }
    
    func getSkills() -> Promise<[Skill]> {
        return cv.then { cv -> Promise<[Skill]> in
            return .value(cv.skills)
        }
    }
    
    func getProjects() -> Promise<[Project]> {
        return cv.then { cv -> Promise<[Project]> in
            return .value(cv.projects)
        }
    }
    
    func getCV() -> Promise<CV> {
        return Promise { seal in
            loadingQueue.safeAsync {
                do {
                    let cv = try self.loadFromBundle()
                    seal.fulfill(cv)
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
    
    func preloadData() -> Promise<Void> {
        let waitAtLeast = after(seconds: 0.5)
        return cv.then { _ in 
            waitAtLeast
        }
    }
    
    private func loadFromBundle() throws -> CV {
        guard let url = self.bundle.url(forResource: "cv", withExtension: "json") else {
            throw Errors.badFileURL
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(CV.self, from: data)
    }
    
    enum Errors:Error {
        case badFileURL
    }
}

extension DataProvider {
    struct Dependency {
        static let bundle = Injection<Bundle>(Bundle(for:DataProvider.self))
        static let loadingQueue = Injection<DispatchQueue>(DispatchQueue.global())
    }
}
