import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var loadingOffset: CGFloat = -1.0
    
    var body: some View {
        if isActive {
            MainView()
        } else {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: 0xFFFF9933),
                        Color(hex: 0xFFFFB84D)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // Ambient gold glow - top left
                Circle()
                    .fill(Color.goldAccent.opacity(0.25))
                    .frame(width: 280, height: 280)
                    .blur(radius: 80)
                    .offset(x: -60, y: -200)
                
                // Ambient white glow - bottom right
                Circle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 200, height: 200)
                    .blur(radius: 60)
                    .offset(x: 100, y: 300)
                
                // Watermark text
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("आम्ही सेवेकरी")
                            .font(Typography.notoSansMarathi(weight: .bold, size: 80))
                            .foregroundColor(Color.white.opacity(0.05))
                            .rotationEffect(.degrees(-15))
                            .offset(x: 80, y: 40)
                    }
                }
                .ignoresSafeArea()
                
                // Center Brand Cluster
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Glassmorphic logo circle
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.20))
                            .frame(width: 96, height: 96)
                            .shadow(color: Color.black.opacity(0.1), radius: 24, x: 0, y: 10)
                        
                        // Placeholder for logo since we don't have the image file
                        Image(systemName: "book.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                    }
                    
                    Spacer().frame(height: 28)
                    
                    // App title
                    Text("आम्ही सेवेकरी")
                        .font(Typography.notoSansMarathi(weight: .heavy, size: 40))
                        .foregroundColor(.white)
                        .kerning(-0.5)
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 10)
                    
                    // Tagline
                    Text("भक्तांसाठी भजन सेवा")
                        .font(Typography.notoSansMarathi(weight: .medium, size: 16))
                        .foregroundColor(Color.white.opacity(0.88))
                        .kerning(0.8)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                
                // Bottom loading section
                VStack(spacing: 12) {
                    Spacer()
                    
                    // Animated loading bar
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.25))
                            .frame(width: 56, height: 3)
                        
                        Capsule()
                            .fill(Color.goldAccent)
                            .frame(width: 18, height: 3)
                            .offset(x: ((loadingOffset + 1.0) / 2.0) * 38)
                    }
                    
                    Text("डिजिटल संकुल")
                        .font(Typography.notoSansMarathi(weight: .medium, size: 11))
                        .foregroundColor(Color.white.opacity(0.60))
                        .kerning(2.0)
                    
                    Spacer().frame(height: 64)
                }
                
                // Footer meta
                VStack {
                    Spacer()
                    Text("V1.0.0 • भजन सेवा")
                        .font(Typography.inter(weight: .regular, size: 10))
                        .foregroundColor(Color.white.opacity(0.38))
                        .kerning(1.5)
                        .padding(.bottom, 24)
                }
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    loadingOffset = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
