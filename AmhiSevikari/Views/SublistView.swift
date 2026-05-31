import SwiftUI
import SwiftData

struct SublistView: View {
    let category: Category
    @Environment(\.presentationMode) var presentationMode
    
    @Query private var bhajans: [Bhajan]
    @State private var viewModel = SublistViewModel()
    
    init(category: Category) {
        self.category = category
        let categoryId = category.id
        _bhajans = Query(filter: #Predicate<Bhajan> { bhajan in
            bhajan.categoryId == categoryId
        }, sort: \.orderIndex)
    }
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Glassmorphic top bar
                HStack(spacing: 12) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.themePrimary)
                            .font(.system(size: 20, weight: .medium))
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("भजन संग्रह")
                            .font(Typography.plusJakartaSans(weight: .semibold, size: 18))
                            .foregroundColor(.themePrimary)
                        Text("BHAJAN COLLECTION")
                            .font(Typography.inter(weight: .regular, size: 9))
                            .kerning(1.5)
                            .foregroundColor(.themeOutline)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.88))
                
                // Search bar — pill style
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.themeOutline)
                    TextField("भजन शोधा...", text: $viewModel.searchText)
                        .font(Typography.notoSansMarathi(weight: .regular, size: 14))
                        .foregroundColor(.themeOnSurface)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.surfaceContainerLowest)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
                // Content
                let filteredList = viewModel.filteredBhajans(from: bhajans)
                
                if filteredList.isEmpty {
                    VStack(spacing: 12) {
                        Spacer()
                        Text("♪")
                            .font(.system(size: 48))
                            .foregroundColor(Color.themePrimaryContainer)
                        Text("भजन सापडले नाही")
                            .font(Typography.notoSansMarathi(weight: .regular, size: 16))
                            .foregroundColor(.themeOnSurfaceVariant)
                        Spacer()
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(Array(filteredList.enumerated()), id: \.element.id) { index, bhajan in
                                SubListBhajanCard(index: index + 1, bhajan: bhajan)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct SubListBhajanCard: View {
    let index: Int
    let bhajan: Bhajan
    
    var body: some View {
        NavigationLink(destination: LyricsView(bhajan: bhajan)) {
            HStack(spacing: 14) {
                // Numbered badge
                ZStack {
                    LinearGradient(
                        colors: [Color(hex: 0xFFFF9933).opacity(0.15), Color(hex: 0xFFFCD400).opacity(0.10)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: 36, height: 36)
                    .cornerRadius(10)
                    
                    Text("\(index)")
                        .font(Typography.inter(weight: .bold, size: 13))
                        .foregroundColor(.themePrimary)
                }
                
                Image(systemName: "music.note")
                    .foregroundColor(Color.themePrimary.opacity(0.65))
                    .font(.system(size: 16))
                
                Text(bhajan.title)
                    .font(Typography.notoSansMarathi(weight: .medium, size: 15))
                    .foregroundColor(.themeOnSurface)
                    .lineLimit(1)
                
                Spacer()
                
                Text("›")
                    .font(.system(size: 22))
                    .foregroundColor(Color.themeOutline.opacity(0.45))
                    .padding(.trailing, 4)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.surfaceContainerLowest)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.03), radius: 1, x: 0, y: 1)
        }
    }
}
