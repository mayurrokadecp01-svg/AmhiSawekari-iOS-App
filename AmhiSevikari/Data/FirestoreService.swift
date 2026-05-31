import Foundation
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    private init() {}
    
    // Equivalent to Android's Firestore integration
    func fetchCategories() async throws -> [Category] {
        let snapshot = try await db.collection("categories")
            .whereField("lastUpdated", isGreaterThanOrEqualTo: 0)
            .getDocuments()
        return snapshot.documents.compactMap { document in
            let data = document.data()
            return Category(
                id: document.documentID,
                name: data["name"] as? String ?? "",
                enName: data["enName"] as? String ?? "",
                icon: data["imageUrl"] as? String ?? "", orderIndex: data["order"] as? Int ?? 0,
                lastUpdated: data["lastUpdated"] as? Int64 ?? Int64(Date().timeIntervalSince1970 * 1000)
            )
        }
    }
    
    func fetchBhajans() async throws -> [Bhajan] {
        let snapshot = try await db.collection("bhajans")
            .whereField("lastUpdated", isGreaterThanOrEqualTo: 0)
            .getDocuments()
        return snapshot.documents.compactMap { document in
            let data = document.data()
            return Bhajan(
                id: document.documentID,
                title: data["title"] as? String ?? "",
                lyrics: data["lyrics"] as? String ?? "",
                categoryId: data["categoryId"] as? String ?? "",
                orderIndex: data["order"] as? Int ?? 0,
                lastUpdated: data["lastUpdated"] as? Int64 ?? Int64(Date().timeIntervalSince1970 * 1000)
            )
        }
    }
}
