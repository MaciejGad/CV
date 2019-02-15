import XCTest
import PromiseKit

@testable import CV

class DataProviderTests: XCTestCase {
    var sut:DataProvider!
    
    override func setUp() {
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil
        DataProvider.Dependency.bundle.overrideOnce = { Bundle(for: DataProviderTests.self) }
        DataProvider.Dependency.loadingQueue.overrideOnce = { DispatchQueue.main }
        sut = DataProvider()
    }

    override func tearDown() {
        sut = nil
    }

    func testLoadingCV() {
        var loadedCV:CV? = nil
        sut.getCV().done { cv in
            loadedCV = cv
            XCTAssertEqual(cv.aboutMe.name, "Maciej Gad")
        }.catch { error in
            XCTFail(error.localizedDescription)
        }
        XCTAssertNotNil(loadedCV)
    }
    
    func testLoadingAboutMe() {
        sut.getAboutMe().done { aboutMe in
            XCTAssertEqual(aboutMe.name, "Maciej Gad")
        }.catch { error in
            XCTFail(error.localizedDescription)
        }
    }
    
    func testLoadingWorkExperience() {
        sut.getWorkExperience().done { workExperience in
            XCTAssertEqual(workExperience.first!.employerName, "Artweb Media")
        }.catch { error in
            XCTFail(error.localizedDescription)
        }
    }
}
