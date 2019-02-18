import Foundation

protocol TestInfo {
    func isRunningTests() -> Bool
}

extension ProcessInfo: TestInfo {
    
    func isRunningTests() -> Bool {
        return environment["XCTestConfigurationFilePath"] != nil
    }
    
}
