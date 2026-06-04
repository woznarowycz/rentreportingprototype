import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - App palette (sourced from the Figma design tokens)
extension Color {
    /// Page background — mint/seafoam (`color/surface/background-primary`)
    static let appBackground = Color(hex: "#EAF5F5")

    /// White surfaces for cards (`color/surface/primary`)
    static let appCardSurface = Color.white

    /// Light gray surface used for "no data" rows (`color/surface/tertiary`)
    static let appTertiarySurface = Color(hex: "#D9DFE5")

    /// Primary text — near-black navy (`color/content/text-primary`)
    static let appPrimaryText = Color(hex: "#0C1E29")

    /// Secondary text (`color/content/text-secondary`)
    static let appSecondaryText = Color(hex: "#2E3943")

    /// Dark teal used for action text + chevrons (`color/action/text-primary`)
    static let appActionTeal = Color(hex: "#346A6E")

    /// Confirmed/positive text color (`color/positive/text-primary`)
    static let appPositiveText = Color(hex: "#0C6C5F")

    /// Light mint background used for confirmation banners, "Confirmed" badge circles,
    /// and the "Linked" pill (`color/positive/surface-primary`)
    static let appPositiveSurface = Color(hex: "#B4F7EE")

    /// Medium teal used inside the banner icon circle (`card-callout/icon-background/positive`)
    static let appPositiveIconBg = Color(hex: "#68EEDC")

    /// Information (unconfirmed) text — steel blue (`color/information/text-primary-active`)
    static let appInformationText = Color(hex: "#235778")

    /// Information surface — light blue used for "Unconfirmed" badge circles
    /// (`color/information/surface-primary`)
    static let appInformationSurface = Color(hex: "#BAD8EB")

    /// Greenish shadow tint used across the design (`color/shadow/primary` at 64% alpha)
    static let appShadow = Color(hex: "#96CACD").opacity(0.32)

    /// Generic "teal accent" alias — points at `appActionTeal` so legacy references compile.
    /// The design actually uses several teals depending on context; prefer the named tokens.
    static let appAccent = appActionTeal
}
