import UIKit
import Foundation

// MARK: LibraryViewModel
final class LibraryViewModel {
    // MARK: - Properties
    var selectedCell: BookCollectionViewCell?
    var mockBooks: [Book] {
        let cover1 = UIImage.mi2.jpegData(compressionQuality: 1.0)
        let book1 = Book(cover: cover1, name: "Мартин Иден", author: "Джек Лондон", status: 67, genre: .none)
        return [book1]
    }
}
