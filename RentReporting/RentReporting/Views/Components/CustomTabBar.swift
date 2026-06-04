import SwiftUI

/// Bottom tab bar styled to match iOS 26's "Liquid Glass" pattern: a floating
/// translucent capsule that sits above the content with the active tab highlighted.
///
/// On iOS 26+ this uses the system `.glassEffect()` material so it picks up real
/// background refraction. On earlier iOS versions it gracefully falls back to a
/// semi-opaque material capsule with a soft shadow.
struct CustomTabBar: View {
    var activeTab: String = "Home"

    private let items: [TabItem] = [
        TabItem(symbol: "house",             activeSymbol: "house.fill",             label: "Home",          showsBadge: false),
        TabItem(symbol: "heart.text.square", activeSymbol: "heart.text.square.fill", label: "Credit Health", showsBadge: true),
        TabItem(symbol: "tag",               activeSymbol: "tag.fill",               label: "Offers",        showsBadge: false),
        TabItem(symbol: "leaf",              activeSymbol: "leaf.fill",              label: "Improve",       showsBadge: false),
        TabItem(symbol: "lock.shield",       activeSymbol: "lock.shield.fill",       label: "Protect",       showsBadge: false)
    ]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(items, id: \.label) { item in
                tabButton(item)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .modifier(LiquidGlassCapsuleBackground())
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }

    @ViewBuilder
    private func tabButton(_ item: TabItem) -> some View {
        let isActive = item.label == activeTab
        let tint: Color = isActive ? .appPrimaryText : Color(hex: "#5A6670")

        VStack(spacing: 2) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: isActive ? item.activeSymbol : item.symbol)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(tint)
                    .frame(width: 28, height: 26)

                if item.showsBadge {
                    Text("1")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 14, height: 14)
                        .background(Color(hex: "#235778"))
                        .clipShape(Circle())
                        .offset(x: 8, y: -2)
                }
            }
            Text(item.label)
                .font(.csClarity(.regular, size: 10))
                .foregroundColor(tint)
                .lineLimit(1)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            // Active "pill" — tinted glass on iOS 26, solid mint on older OSes
            Group {
                if isActive {
                    ActiveTabHighlight()
                } else {
                    Color.clear
                }
            }
        )
    }
}

private struct TabItem {
    let symbol: String
    let activeSymbol: String
    let label: String
    let showsBadge: Bool
}

// MARK: - Liquid Glass containers
/// The bar background — a floating capsule. On iOS 26+ it uses the real Liquid Glass
/// material. Otherwise it falls back to an `.ultraThinMaterial` capsule that mimics
/// the same translucent feel.
private struct LiquidGlassCapsuleBackground: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffect(.regular, in: Capsule())
        } else {
            content
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    Capsule().strokeBorder(Color.white.opacity(0.5), lineWidth: 0.5)
                )
                .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 4)
        }
    }
}

/// Tinted highlight behind the active tab. We use a solid tinted capsule rather
/// than a nested glass effect — Apple's iOS 26 tab bar uses the same approach
/// (the outer bar is glass, the active pill is a tint, not glass-on-glass).
private struct ActiveTabHighlight: View {
    var body: some View {
        Capsule().fill(Color.appPositiveSurface.opacity(0.85))
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color.appBackground.ignoresSafeArea()
        CustomTabBar()
    }
}
