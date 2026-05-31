import SwiftUI

struct LyricsView: View {
    let bhajan: Bhajan
    @Environment(\.presentationMode) var presentationMode
    
    @State private var viewModel = LyricsViewModel()
    @State private var fontSize: CGFloat = 18
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            // Subtle ambient glow watermark background
            Circle()
                .fill(Color(hex: 0xFF9933).opacity(0.04))
                .frame(width: 360, height: 360)
                .blur(radius: 100)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            
            VStack(spacing: 0) {
                // Glassmorphic TopAppBar
                HStack(spacing: 12) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.themePrimary)
                            .font(.system(size: 20, weight: .medium))
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(bhajan.title)
                            .font(Typography.plusJakartaSans(weight: .semibold, size: 16))
                            .foregroundColor(.themePrimary)
                            .lineLimit(1)
                        Text("नित्य सेवा")
                            .font(Typography.inter(weight: .regular, size: 10))
                            .kerning(1.5)
                            .foregroundColor(.themeOutline)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.themePrimary)
                            .rotationEffect(.degrees(90))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.88))
                
                // Main scrollable content
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        // Category badge
                        Text("भक्ती संगीत")
                            .font(Typography.inter(weight: .medium, size: 12))
                            .foregroundColor(.themePrimary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(Color.themeSecondaryContainer.opacity(0.30))
                            .clipShape(Capsule())
                            .padding(.top, 24)
                        
                        Spacer().frame(height: 20)
                        
                        // Bhajan title
                        Text(bhajan.title)
                            .font(Typography.notoSansMarathi(weight: .heavy, size: 28))
                            .kerning(-0.3)
                            .lineSpacing(10)
                            .foregroundColor(.themeOnSurface)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 12)
                        
                        // Orange accent divider
                        Capsule()
                            .fill(Color.themePrimaryContainer)
                            .frame(width: 48, height: 3)
                        
                        Spacer().frame(height: 28)
                        
                        // Lyrics card
                        VStack(spacing: 0) {
                            let stanzas = bhajan.lyrics.components(separatedBy: "\n\n")
                            ForEach(0..<stanzas.count, id: \.self) { idx in
                                let stanza = stanzas[idx].trimmingCharacters(in: .whitespacesAndNewlines)
                                if !stanza.isEmpty {
                                    Text(stanza)
                                        .font(Typography.notoSansMarathi(weight: .regular, size: fontSize))
                                        .lineSpacing(fontSize * 0.65)
                                        .foregroundColor(.themeOnSurfaceVariant)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                    
                                    if idx < stanzas.count - 1 {
                                        Spacer().frame(height: 20)
                                    }
                                }
                            }
                            
                            Spacer().frame(height: 24)
                            
                            // Decorative separator
                            Text("✦")
                                .font(.system(size: 18))
                                .foregroundColor(.themePrimaryContainer)
                            
                            Spacer().frame(height: 16)
                            
                            // God name sign-off
                            Text("|| श्री स्वामी समर्थ ||")
                                .font(Typography.notoSansMarathi(weight: .semibold, size: 15))
                                .foregroundColor(.themePrimary)
                        }
                        .padding(24)
                        .background(Color.surfaceContainerLowest)
                        .cornerRadius(28)
                        .shadow(color: Color.black.opacity(0.03), radius: 1, x: 0, y: 1)
                        .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 120)
                    }
                }
            }
            
            // Floating Action Buttons & Bottom save bar
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        // Increase font
                        Button(action: {
                            if fontSize < 32 { fontSize += 2 }
                        }) {
                            Circle()
                                .fill(Color.themePrimary)
                                .frame(width: 52, height: 52)
                                .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
                                .overlay(
                                    Image(systemName: "plus")
                                        .font(.system(size: 22, weight: .medium))
                                        .foregroundColor(.white)
                                )
                        }
                        
                        // Decrease font
                        Button(action: {
                            if fontSize > 12 { fontSize -= 2 }
                        }) {
                            Circle()
                                .fill(Color.surfaceContainerLowest)
                                .frame(width: 52, height: 52)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                                .overlay(
                                    Image(systemName: "minus")
                                        .font(.system(size: 22, weight: .medium))
                                        .foregroundColor(.themePrimary)
                                )
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 100)
                }
            }
            
            // Bottom save bar
            VStack(spacing: 0) {
                Spacer()
                ZStack(alignment: .bottom) {
                    LinearGradient(
                        colors: [Color.themeBackground.opacity(0), Color.themeBackground],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 100)
                    
                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 16))
                            Text("आवडते म्हणून जतन करा")
                                .font(Typography.notoSansMarathi(weight: .semibold, size: 14))
                        }
                        .foregroundColor(.themeOnPrimaryContainer)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .background(Color.themePrimaryContainer.opacity(0.15))
                        .clipShape(Capsule())
                    }
                    .padding(.bottom, 24)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
    }
}
