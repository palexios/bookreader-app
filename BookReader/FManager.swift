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
    func getMockFB2BookPath() -> String? {
        Bundle.main.path(forResource: "book", ofType: "fb2")
    }
    
    func writeMockFB2Book() {
        let destinationURL = self.documentsPath.appending("book.fb2")
        try? FileManager.default.copyItem(atPath: self.getMockFB2BookPath()!, toPath: destinationURL)
    }
    
}
