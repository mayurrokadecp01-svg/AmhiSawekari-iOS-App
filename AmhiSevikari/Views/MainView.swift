import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Category.orderIndex) private var categories: [Category]
    @Query(sort: \Bhajan.orderIndex) private var allBhajans: [Bhajan]
    
    @State private var viewModel = MainViewModel()
    @State private var showSocialSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
                // Subtle ambient saffron radial glow — top right corner
                VStack {
                    HStack {
                        Spacer()
                        Circle()
                            .fill(Color(hex: 0xFF9933).opacity(0.08))
                            .frame(width: 360, height: 360)
                            .blur(radius: 100)
                            .offset(x: 100, y: -100)
                    }
                    Spacer()
                }
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Glassmorphic top bar
                    HStack {
                        Text("आम्ही सेवेकरी")
                            .font(Typography.notoSansMarathi(weight: .bold, size: 22))
                            .foregroundColor(.themePrimary)
                        
                        Spacer()
                        
                        // Follow Us pill button
                        Button(action: {
                            showSocialSheet = true
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 12))
                                Text("फॉलो करा")
                                    .font(Typography.plusJakartaSans(weight: .semibold, size: 12))
                            }
                            .foregroundColor(.themePrimary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 9)
                            .background(Color.themePrimaryContainer.opacity(0.18))
                            .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(Color.white.opacity(0.92))
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            
                            // Peace Header
                            PeaceHeaderView()
                            
                            // Pill Search Bar
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.themeOutline)
                                TextField("भजन किंवा देवता शोधा...", text: $viewModel.searchText)
                                    .font(Typography.notoSansMarathi(weight: .regular, size: 14))
                                    .foregroundColor(.themeOnSurface)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.surfaceContainerLowest)
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 8)
                            
                            // Section header
                            HStack {
                                Text("देवता आणि सेवा")
                                    .font(Typography.plusJakartaSans(weight: .bold, size: 18))
                                    .foregroundColor(.themeOnSurface)
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            
                            // Content
                            if viewModel.isRefreshing {
                                ProgressView()
                                    .frame(maxWidth: .infinity, minHeight: 200)
                                    .tint(.themePrimary)
                            } else if categories.isEmpty {
                                Text("माहिती समक्रमित होत आहे...")
                                    .font(Typography.notoSansMarathi(weight: .regular, size: 14))
                                    .foregroundColor(.themeOnSurfaceVariant)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(40)
                            } else {
                                let filteredCategories = viewModel.searchText.isEmpty ? categories : categories.filter { category in
                                    let matchesCategory = category.name.localizedCaseInsensitiveContains(viewModel.searchText) ||
                                                          category.enName.localizedCaseInsensitiveContains(viewModel.searchText) ||
                                                          category.searchToken.localizedCaseInsensitiveContains(viewModel.searchText)
                                                          
                                    let categoryBhajans = allBhajans.filter { $0.categoryId == category.id }
                                    let matchesBhajan = categoryBhajans.contains { bhajan in
                                        bhajan.title.localizedCaseInsensitiveContains(viewModel.searchText) ||
                                        bhajan.searchToken.localizedCaseInsensitiveContains(viewModel.searchText)
                                    }
                                    
                                    return matchesCategory || matchesBhajan
                                }
                                
                                if filteredCategories.isEmpty {
                                    Text("\"\(viewModel.searchText)\" साठी काहीही सापडले नाही")
                                        .font(Typography.notoSansMarathi(weight: .regular, size: 14))
                                        .foregroundColor(.themeOnSurfaceVariant)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(40)
                                } else {
                                    ForEach(filteredCategories) { category in
                                        let categoryBhajans = allBhajans.filter { $0.categoryId == category.id }
                                        
                                        let isCategoryMatch = category.name.localizedCaseInsensitiveContains(viewModel.searchText) ||
                                                              category.enName.localizedCaseInsensitiveContains(viewModel.searchText) ||
                                                              category.searchToken.localizedCaseInsensitiveContains(viewModel.searchText)
                                                              
                                        let matchingBhajans = categoryBhajans.filter {
                                            $0.title.localizedCaseInsensitiveContains(viewModel.searchText) ||
                                            $0.searchToken.localizedCaseInsensitiveContains(viewModel.searchText)
                                        }
                                        
                                        let displayBhajans = (viewModel.searchText.isEmpty || isCategoryMatch) ? categoryBhajans : matchingBhajans
                                        
                                        ExpandableCategoryCard(
                                            category: category, 
                                            bhajans: displayBhajans,
                                            isSearchActive: !viewModel.searchText.isEmpty
                                        )
                                    }
                                }
                            }
                            
                            // Quote Bento Section
                            QuoteBentoSection()
                                .padding(.top, 8)
                            
                            Spacer().frame(height: 120)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSocialSheet) {
                SocialFollowSheet()
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(28)
            }
            .refreshable {
                await viewModel.refreshData()
            }
            .onAppear {
                Repository.shared.setup(context: modelContext)
            }
        }
    }
}

// MARK: - Peace Header
struct PeaceHeaderView: View {
    var body: some View {
        let hour = Calendar.current.component(.hour, from: Date())
        let greetingInfo: (String, String) = {
            switch hour {
            case 5...11:
                return ("शुभ प्रभात", "तुमचा दिवस आध्यात्मिक ऊर्जेने भरलेला जावो.")
            case 12...16:
                return ("शुभ दुपार", "तुमचा आजचा दिवस आनंददायी आणि भक्तीमय जावो.")
            default:
                return ("शुभ संध्याकाळ", "तुमची संध्याकाळ शांतता आणि समाधानाने भरलेली जावो.")
            }
        }()
        
        VStack(alignment: .leading, spacing: 0) {
            Text("नमस्कार")
                .font(Typography.notoSansMarathi(weight: .semibold, size: 13))
                .kerning(1.0)
                .foregroundColor(.themePrimary)
            
            Spacer().frame(height: 6)
            
            Text(greetingInfo.0)
                .font(Typography.plusJakartaSans(weight: .heavy, size: 36))
                .kerning(-0.5)
                .foregroundColor(.themeOnSurface)
            
            Spacer().frame(height: 8)
            
            Text(greetingInfo.1)
                .font(Typography.notoSansMarathi(weight: .regular, size: 14))
                .lineSpacing(4)
                .foregroundColor(.themeOnSurfaceVariant)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
    }
}

// MARK: - Expandable Category Card
struct ExpandableCategoryCard: View {
    let category: Category
    let bhajans: [Bhajan]
    let isSearchActive: Bool
    
    @State private var expanded: Bool = false
    
    init(category: Category, bhajans: [Bhajan], isSearchActive: Bool = false) {
        self.category = category
        self.bhajans = bhajans
        self.isSearchActive = isSearchActive
        _expanded = State(initialValue: isSearchActive)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Row
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    expanded.toggle()
                }
            }) {
                HStack(spacing: 0) {
                    // Circle icon
                    Circle()
                        .fill(expanded ? Color.themePrimary : Color(hex: 0xFFFFF0E0))
                        .frame(width: 56, height: 56)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 24))
                                .foregroundColor(expanded ? .white : .themePrimary)
                        )
                    
                    Spacer().frame(width: 14)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(category.name)
                            .font(Typography.notoSansMarathi(weight: .bold, size: 16))
                            .foregroundColor(.themeOnSurface)
                            .lineLimit(1)
                        
                        Text(expanded ? (category.enName.isEmpty ? "Bhajan Collection" : category.enName) : "\(bhajans.count) भजन")
                            .font(Typography.inter(weight: .regular, size: 12))
                            .foregroundColor(expanded ? .themePrimary : .themeOutline)
                    }
                    
                    Spacer()
                    
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.themePrimary)
                        .font(.system(size: 18, weight: .semibold))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
            
            // Expanded Content
            if expanded {
                VStack(spacing: 6) {
                    ForEach(bhajans.prefix(5)) { bhajan in
                        NavigationLink(destination: LyricsView(bhajan: bhajan)) {
                            HStack(spacing: 0) {
                                Image(systemName: "music.note")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.themePrimary.opacity(0.60))
                                
                                Spacer().frame(width: 10)
                                
                                Text(bhajan.title)
                                    .font(Typography.notoSansMarathi(weight: .medium, size: 14))
                                    .foregroundColor(.themeOnSurface)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.themeOutline.opacity(0.50))
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .cornerRadius(14)
                        }
                    }
                    
                    Spacer().frame(height: 4)
                    
                    NavigationLink(destination: SublistView(category: category)) {
                        Text(bhajans.count > 5 ? "सर्व \(bhajans.count) भजन पहा →" : "संपूर्ण श्रेणी पहा →")
                            .font(Typography.notoSansMarathi(weight: .semibold, size: 13))
                            .foregroundColor(.themePrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
        .background(expanded ? Color(hex: 0xFFF0EDE8) : Color.surfaceContainerLowest)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(expanded ? 0.08 : 0.03), radius: expanded ? 3 : 1, x: 0, y: 1)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .onChange(of: isSearchActive) { newValue in
            withAnimation(.easeInOut(duration: 0.2)) {
                expanded = newValue
            }
        }
    }
}

// MARK: - Quote Bento Section
struct QuoteBentoSection: View {
    var body: some View {
        let hour = Calendar.current.component(.hour, from: Date())
        let quote: String = {
            switch hour {
            case 5...11:
                return "सूर्योदयाची पहिली किरणे जशी अंधार नष्ट करतात, तशी परमेश्वराची भक्ती मनातील भीती नष्ट करते."
            case 12...16:
                return "कर्तव्य पालनातच खऱ्या अर्थाने देवाची सेवा सामावलेली असते."
            default:
                return "दिवसाच्या थकव्यानंतर देवाचे नाव घेतल्याने मनाला असीम शांती मिळते."
            }
        }()
        
        VStack(spacing: 12) {
            // Main Quote Card
            VStack(alignment: .leading, spacing: 0) {
                Text("❝")
                    .font(.system(size: 28))
                    .foregroundColor(Color.white.opacity(0.55))
                
                Spacer().frame(height: 6)
                
                Text(quote)
                    .font(Typography.notoSansMarathi(weight: .semibold, size: 15))
                    .lineSpacing(6)
                    .foregroundColor(.white)
                
                Spacer().frame(height: 14)
                
                HStack {
                    Text("- संत विचार")
                        .font(Typography.inter(weight: .regular, size: 11))
                        .foregroundColor(Color.white.opacity(0.70))
                    
                    Spacer()
                    
                    Text("शेअर करा")
                        .font(Typography.plusJakartaSans(weight: .bold, size: 10))
                        .kerning(0.8)
                        .foregroundColor(.white)
                        .padding(.horizontal, 13)
                        .padding(.vertical, 7)
                        .background(Color.white.opacity(0.18))
                        .clipShape(Capsule())
                }
            }
            .padding(22)
            .background(
                LinearGradient(colors: [Color(hex: 0xFF7A4000), Color(hex: 0xFFAF5C00)], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(28)
            
            // Sub Cards
            HStack(spacing: 10) {
                // Panchang
                VStack(alignment: .leading, spacing: 0) {
                    Text("📅").font(.system(size: 20))
                    Spacer().frame(height: 6)
                    Text("आजचा पंचांग")
                        .font(Typography.plusJakartaSans(weight: .bold, size: 12))
                        .foregroundColor(Color(hex: 0xFF6E5C00))
                    Text("श्रावण शुद्ध दशमी")
                        .font(Typography.notoSansMarathi(weight: .regular, size: 10))
                        .foregroundColor(Color(hex: 0xFF6E5C00).opacity(0.78))
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.goldAccent)
                .cornerRadius(20)
                
                // Festival
                VStack(alignment: .leading, spacing: 0) {
                    Text("🔔").font(.system(size: 20))
                    Spacer().frame(height: 6)
                    Text("पुढील उत्सव")
                        .font(Typography.plusJakartaSans(weight: .bold, size: 12))
                        .foregroundColor(.themeOnSurface)
                    Text("महाशिवरात्री")
                        .font(Typography.notoSansMarathi(weight: .regular, size: 10))
                        .foregroundColor(.themePrimary)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: 0xFFE8E8E8))
                .cornerRadius(20)
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Social Follow Sheet
struct SocialFollowSheet: View {
    let links = [
        ("व्हॉट्सॲप", "WhatsApp Channel", Color(hex: 0xFF25D366), "message.fill"),
        ("इन्स्टाग्राम", "@amhisevekari", Color(hex: 0xFFE1306C), "camera.fill"),
        ("फेसबुक", "Amhi Sevekari", Color(hex: 0xFF1877F2), "f.square.fill"),
        ("यूट्यूब", "Amhi Sevekari", Color(hex: 0xFFFF0000), "play.rectangle.fill")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color(hex: 0xFFE0E0E0))
                .frame(width: 36, height: 4)
                .padding(.top, 12)
            
            Spacer().frame(height: 16)
            
            Text("आम्हाला फॉलो करा")
                .font(Typography.plusJakartaSans(weight: .bold, size: 20))
                .foregroundColor(.themeOnSurface)
            
            Spacer().frame(height: 4)
            
            Text("सोशल मीडियावर जुडा आणि भक्तीसाठी अपडेट मिळवा")
                .font(Typography.notoSansMarathi(weight: .regular, size: 13))
                .foregroundColor(.themeOnSurfaceVariant)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 20)
            
            VStack(spacing: 10) {
                ForEach(links, id: \.0) { link in
                    HStack(spacing: 14) {
                        Circle()
                            .fill(link.2)
                            .frame(width: 46, height: 46)
                            .overlay(
                                Image(systemName: link.3)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            )
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(link.0)
                                .font(Typography.notoSansMarathi(weight: .bold, size: 15))
                                .foregroundColor(.themeOnSurface)
                            Text(link.1)
                                .font(Typography.inter(weight: .regular, size: 12))
                                .foregroundColor(.themeOutline)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(link.2)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(link.2.opacity(0.08))
                    .cornerRadius(18)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    MainView()
}
