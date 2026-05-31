import SwiftUI

extension Color {
    static let themePrimary = Color(hex: 0x8F4E00)
    static let themeOnPrimary = Color(hex: 0xFFFFFF)
    static let themePrimaryContainer = Color(hex: 0xFF9933)
    static let themeOnPrimaryContainer = Color(hex: 0x693800)
    static let themeSecondary = Color(hex: 0x705D00)
    static let themeOnSecondary = Color(hex: 0xFFFFFF)
    static let themeSecondaryContainer = Color(hex: 0xFCD400)
    static let themeOnSecondaryContainer = Color(hex: 0x6E5C00)
    static let themeTertiary = Color(hex: 0x835500)
    static let themeOnTertiary = Color(hex: 0xFFFFFF)
    static let themeTertiaryContainer = Color(hex: 0xE9A43C)
    static let themeOnTertiaryContainer = Color(hex: 0x603D00)
    static let themeError = Color(hex: 0xBA1A1A)
    static let themeOnError = Color(hex: 0xFFFFFF)
    static let themeErrorContainer = Color(hex: 0xFFDAD6)
    static let themeOnErrorContainer = Color(hex: 0x93000A)
    static let themeBackground = Color(hex: 0xF9F9F9)
    static let themeOnBackground = Color(hex: 0x1A1C1C)
    static let themeSurface = Color(hex: 0xF9F9F9)
    static let themeOnSurface = Color(hex: 0x1A1C1C)
    static let themeSurfaceVariant = Color(hex: 0xE2E2E2)
    static let themeOnSurfaceVariant = Color(hex: 0x554336)
    static let themeOutline = Color(hex: 0x887364)
    static let themeOutlineVariant = Color(hex: 0xDBC2B0)

    // Extended Custom Color Tokens
    static let surfaceContainerLowest = Color(hex: 0xFFFFFF)
    static let surfaceContainerLow = Color(hex: 0xF3F3F3)
    static let surfaceContainer = Color(hex: 0xEEEEEE)
    static let surfaceContainerHigh = Color(hex: 0xE8E8E8)
    static let surfaceContainerHighest = Color(hex: 0xE2E2E2)
    static let saffronGlow = Color(hex: 0xFF9933).opacity(0.10)
    static let goldAccent = Color(hex: 0xFCD400)
    static let deepSaffron = Color(hex: 0x8F4E00)
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
