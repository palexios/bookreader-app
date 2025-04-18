import Foundation

struct BookModel: Equatable {
    var cover: Data?
    var data: Data?
    var name: String
    var author: String
    var isRead: Bool
    var progress: Int64
    var genre: String
}
