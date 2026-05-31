import Foundation
import SwiftData
import SwiftUI
import FirebaseCore

@Observable
class Repository {
    static let shared = Repository()
    
    var modelContext: ModelContext?
    
    private init() {}
    
    func setup(context: ModelContext) {
        self.modelContext = context
    }
    
    // Sync logic similar to Android's Repository
    func syncData() async {
        guard let context = modelContext else { return }
        
        do {
            let firestoreCategories = try await FirestoreService.shared.fetchCategories()
            let firestoreBhajans = try await FirestoreService.shared.fetchBhajans()
            
            await MainActor.run {
                // In a production app, we would compare lastUpdated and perform differential updates.
                // For simplicity, we just insert (upsert requires unique constraints in SwiftData).
                
                // Fetch existing to avoid duplicates or update them
                let fetchCategories = FetchDescriptor<Category>()
                if let existingCategories = try? context.fetch(fetchCategories) {
                    for existing in existingCategories {
                        context.delete(existing)
                    }
                }
                
                let fetchBhajans = FetchDescriptor<Bhajan>()
                if let existingBhajans = try? context.fetch(fetchBhajans) {
                    for existing in existingBhajans {
                        context.delete(existing)
                    }
                }
                
                // Insert new ones
                for category in firestoreCategories {
                    category.searchToken = category.name.transliteratedToEnglish()
                    context.insert(category)
                }
                
                for bhajan in firestoreBhajans {
                    bhajan.searchToken = bhajan.title.transliteratedToEnglish()
                    // Link to category if possible
                    if let cat = firestoreCategories.first(where: { $0.id == bhajan.categoryId }) {
                        bhajan.category = cat
                    }
                    context.insert(bhajan)
                }
                
                try? context.save()
            }
        } catch {
            print("Error syncing data: \(error)")
        }
    }
}
