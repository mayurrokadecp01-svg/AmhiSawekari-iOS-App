import SwiftUI

public struct Typography {
    
    // Auto-register fonts if they aren't in Info.plist or bundle resources properly
    public static func registerFonts() {
        let fontNames = [
            "inter_regular", "inter_medium", "inter_semi_bold",
            "noto_sans_marathi_regular", "noto_sans_marathi_medium", "noto_sans_marathi_semi_bold", "noto_sans_marathi_bold",
            "plus_jakarta_sans_regular", "plus_jakarta_sans_medium", "plus_jakarta_sans_semi_bold", "plus_jakarta_sans_bold", "plus_jakarta_sans_extra_bold"
        ]
        
        for fontName in fontNames {
            if let url = Bundle.main.url(forResource: fontName, withExtension: "ttf") {
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            } else if let url = Bundle.main.url(forResource: fontName, withExtension: "ttf", subdirectory: "Fonts") {
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            }
        }
    }
    
    // Plus Jakarta Sans
    public static func plusJakartaSans(weight: Font.Weight, size: CGFloat) -> Font {
        let name: String
        switch weight {
        case .medium: name = "PlusJakartaSans-Medium"
        case .semibold: name = "PlusJakartaSans-SemiBold"
        case .bold: name = "PlusJakartaSans-Bold"
        case .heavy, .black: name = "PlusJakartaSans-ExtraBold"
        default: name = "PlusJakartaSans-Regular"
        }
        return Font.custom(name, size: size)
    }
    
    // Inter
    public static func inter(weight: Font.Weight, size: CGFloat) -> Font {
        let name: String
        switch weight {
        case .medium: name = "Inter-Medium"
        case .semibold, .bold: name = "Inter-SemiBold"
        default: name = "Inter-Regular"
        }
        return Font.custom(name, size: size)
    }
    
    // Noto Sans Marathi
    public static func notoSansMarathi(weight: Font.Weight, size: CGFloat) -> Font {
        let name: String
        switch weight {
        case .medium: name = "NotoSansMarathi-Medium"
        case .semibold: name = "NotoSansMarathi-SemiBold"
        case .bold, .heavy, .black: name = "NotoSansMarathi-Bold"
        default: name = "NotoSansMarathi-Regular"
        }
        return Font.custom(name, size: size)
    }
}
