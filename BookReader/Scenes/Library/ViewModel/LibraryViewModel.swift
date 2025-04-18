import UIKit
import Foundation
import CoreData

// MARK: LibraryViewModel
final class LibraryViewModel {
    // MARK: - Properties
    var selectedCell: BookCollectionViewCell?
    private var coreData = CoreDataManager.shared
    
    var books: [BookModel] {
        return getBooks()
    }
    
    private func getBooks() -> [BookModel] {
        let books = self.coreData.fetchBooks()
        return books.map { $0.toBookModel() }
    }
}
