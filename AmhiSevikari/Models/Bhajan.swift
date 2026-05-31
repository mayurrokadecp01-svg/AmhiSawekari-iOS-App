import Foundation
import SwiftData

@Model
final class Bhajan: Identifiable {
    @Attribute(.unique) var id: String
    var title: String
    var lyrics: String
    var categoryId: String
    var orderIndex: Int
    var lastUpdated: Int64
    var searchToken: String = ""
    
    // Relationship to Category
    var category: Category?
    
    init(id: String = UUID().uuidString,
         title: String,
         lyrics: String,
         categoryId: String,
         orderIndex: Int = 0,
         lastUpdated: Int64 = 0,
         searchToken: String = "") {
        self.id = id
        self.title = title
        self.lyrics = lyrics
        self.categoryId = categoryId
        self.orderIndex = orderIndex
        self.lastUpdated = lastUpdated
        self.searchToken = searchToken
    }
}
