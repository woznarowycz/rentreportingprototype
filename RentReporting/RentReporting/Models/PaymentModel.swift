import SwiftUI

enum PaymentStatus: String, Hashable {
    case confirmed
    case unconfirmed
    case noData

    var label: String {
        switch self {
        case .confirmed:   return "Confirmed"
        case .unconfirmed: return "Unconfirmed"
        case .noData:      return "No data"
        }
    }

    /// Custom asset name used inside the status badge.
    var iconName: String {
        switch self {
        case .confirmed:   return "icon-payment-confirmed"
        case .unconfirmed: return "icon-payment-coming-soon"
        case .noData:      return "icon-payment-nodata"
        }
    }

    /// Light fill background for the circular status badge (matches the Figma).
    var badgeBackground: Color {
        switch self {
        case .confirmed:   return .appPositiveSurface     // light mint
        case .unconfirmed: return .appInformationSurface  // light blue
        case .noData:      return .appTertiarySurface     // light gray
        }
    }

    /// Symbol/foreground color rendered inside the badge.
    var badgeForeground: Color {
        switch self {
        case .confirmed:   return .appPositiveText        // dark teal
        case .unconfirmed: return .appInformationText     // steel blue
        case .noData:      return .appSecondaryText
        }
    }

    /// Row background — `noData` rows have a slightly grey/translucent card so they read as muted.
    var rowBackground: Color {
        switch self {
        case .noData: return Color(hex: "#F2F4F6")
        default:      return .white
        }
    }
}

struct Payment: Hashable, Identifiable {
    let id = UUID()
    let month: String   // e.g. "August"
    let year: Int       // e.g. 2026
    let status: PaymentStatus

    var monthYearTitle: String {
        "\(month) \(year)"
    }
}
