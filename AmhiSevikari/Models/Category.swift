import Foundation
import SwiftData

@Model
final class Category: Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    var enName: String
    var orderIndex: Int // mapped from 'order' since 'order' can sometimes be a reserved keyword or ambiguous
    var lastUpdated: Int64
    var imageUrl: String?
    var searchToken: String = ""
    
    // Relationship to Bhajans
    @Relationship(deleteRule: .cascade, inverse: \Bhajan.category)
    var bhajans: [Bhajan]? = []
    
    init(id: String = UUID().uuidString,
         name: String,
         enName: String = "",
         icon: String = "",
         orderIndex: Int = 0,
         lastUpdated: Int64 = 0,
         searchToken: String = "") {
        self.id = id
        self.name = name
        self.enName = enName
        self.orderIndex = orderIndex
        self.lastUpdated = lastUpdated
        self.imageUrl = icon
        self.searchToken = searchToken
    }
}
