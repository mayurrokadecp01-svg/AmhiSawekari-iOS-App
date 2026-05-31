import SwiftUI
import SwiftData

@Observable
class MainViewModel {
    var searchText: String = ""
    var isRefreshing: Bool = false
    
    // Refresh action from UI
    func refreshData() async {
        isRefreshing = true
        await Repository.shared.syncData()
        isRefreshing = false
    }
}
