import SwiftUI

struct AppCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.themeSurface)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

extension View {
    func appCardStyle() -> some View {
        modifier(AppCardStyle())
    }
}
