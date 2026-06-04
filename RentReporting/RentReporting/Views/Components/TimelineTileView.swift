import SwiftUI

/// A 109×109pt tile used in the horizontal "Latest payments" timeline on the dashboard.
/// The layout matches the Figma:
///   • Top row — month abbreviation (left) and a small "+" icon (right)
///   • Middle  — a filled circle with the status icon (large)
///   • Bottom  — status label
struct TimelineTileView: View {
    let monthAbbreviation: String
    let isConfirmed: Bool

    var body: some View {
        VStack(spacing: 0) {
            // Top row
            HStack {
                Text(monthAbbreviation)
                    .font(.csClarity(.bold, size: 14))
                    .foregroundColor(.appPrimaryText)
                Spacer()
                Image(systemName: "plus")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.appSecondaryText.opacity(0.7))
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)

            Spacer(minLength: 0)

            // Middle status circle
            ZStack {
                Circle()
                    .fill(circleBackground)
                Image(systemName: centerSymbol)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(circleForeground)
            }
            .frame(width: 36, height: 36)

            Spacer(minLength: 0)

            // Status label
            Text(isConfirmed ? "Confirmed" : "Coming soon")
                .font(.csClarity(.regular, size: 11))
                .foregroundColor(isConfirmed ? .appPositiveText : .appSecondaryText)
                .padding(.bottom, 10)
        }
        .frame(width: 109, height: 109)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .appShadow, radius: 8, x: 0, y: 2)
    }

    private var circleBackground: Color {
        isConfirmed ? .appPositiveSurface : Color(hex: "#E6ECEF")
    }

    private var circleForeground: Color {
        isConfirmed ? .appPositiveText : .appSecondaryText
    }

    private var centerSymbol: String {
        isConfirmed ? "checkmark" : "clock"
    }
}

// MARK: - See all tile

/// The leftmost tile in the horizontal timeline. Tapping it navigates to AllPaymentsView.
struct SeeAllTileView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)

            ZStack {
                Circle()
                    .fill(Color(hex: "#E6ECEF"))
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appSecondaryText)
            }
            .frame(width: 36, height: 36)

            Spacer(minLength: 0)

            Text("See all\npayments")
                .font(.csClarity(.regular, size: 11))
                .foregroundColor(.appSecondaryText)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
        }
        .frame(width: 109, height: 109)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .appShadow, radius: 8, x: 0, y: 2)
    }
}

#Preview {
    HStack {
        SeeAllTileView()
        TimelineTileView(monthAbbreviation: "Jul", isConfirmed: true)
        TimelineTileView(monthAbbreviation: "Aug", isConfirmed: true)
        TimelineTileView(monthAbbreviation: "Sep", isConfirmed: false)
    }
    .padding()
    .background(Color.appBackground)
}
