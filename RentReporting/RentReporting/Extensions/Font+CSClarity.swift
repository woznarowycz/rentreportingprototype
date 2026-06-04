import SwiftUI

extension Font {
    /// Body / UI weights for CSClarity.
    static func csClarity(_ weight: CSClarityWeight, size: CGFloat) -> Font {
        .custom(weight.fontName, size: size)
    }

    /// Display weight — use for large hero numbers (e.g. "07").
    static func csClarityDisplay(size: CGFloat) -> Font {
        .custom("CSClarityDisplay-Heavy", size: size)
    }
}

enum CSClarityWeight {
    case thin, light, book, regular, medium, bold, black

    var fontName: String {
        switch self {
        case .thin:    return "CSClarity-Thin"
        case .light:   return "CSClarity-Light"
        case .book:    return "CSClarity-Book"
        case .regular: return "CSClarity-Regular"
        case .medium:  return "CSClarity-Medium"
        case .bold:    return "CSClarity-Bold"
        case .black:   return "CSClarity-Black"
        }
    }
}
