import Foundation
import SwiftData

@Observable
class SublistViewModel {
    var searchText: String = ""
    
    func filteredBhajans(from bhajans: [Bhajan]) -> [Bhajan] {
        if searchText.isEmpty {
            return bhajans.sorted { $0.orderIndex < $1.orderIndex }
        } else {
            return bhajans.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.lyrics.localizedCaseInsensitiveContains(searchText) ||
                $0.searchToken.localizedCaseInsensitiveContains(searchText)
            }.sorted { $0.orderIndex < $1.orderIndex }
        }
    }
}
