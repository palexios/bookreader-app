import Foundation

// MARK: - FManager
final class FManager {
    // MARK: - Properties
    static let shared = FManager()
    
    var documentsPath: String {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path()
    }
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods Mock
    func getMockFB2BookData() -> Data? {
        if FileManager.default.fileExists(atPath: self.getMockFB2BookPath()) {
            if let data = try? Data(contentsOf: URL(string: self.getMockFB2BookPath())!) {
                return data
            }
        }
        return nil
    }
    
    func getMockFB2BookPath() -> String {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path().appending("book.fb2")
    }
    
    func getMockFB2BookBundlePath() -> String? {
        Bundle.main.path(forResource: "book", ofType: "fb2")
    }
    
    func writeMockFB2Book() {
        let destinationURL = self.documentsPath.appending("book.fb2")
        try? FileManager.default.copyItem(atPath: self.getMockFB2BookPath(), toPath: destinationURL)
    }
}
