import Foundation
import PromiseKit
import InjectStory

protocol DocumentProviderInput {
    func resolve(filename:String, withExtension ext: String?) -> URL?
}


class DocumentProvider:DocumentProviderInput {
    private let bundle:Bundle = Dependency.bundle.inject()
    
    func resolve(filename:String, withExtension ext: String?) -> URL? {
        return bundle.url(forResource: filename, withExtension: ext)
    }
}


extension DocumentProvider {
    struct Dependency {
        static let bundle = Injection<Bundle>(Bundle.main)
    }
}
