import SwiftUI

/// A row card used in AllPaymentsView. Tapping the row navigates to PaymentDetailView.
/// In the Figma every status uses the same circular badge shape — just with different
/// fill + icon colors. "No data" rows additionally use a slightly grey card background.
struct PaymentRowView: View {
    let payment: Payment

    var body: some View {
        HStack(spacing: 16) {
            statusBadge
            VStack(alignment: .leading, spacing: 2) {
                Text(payment.month)
                    .font(.csClarity(.bold, size: 16))
                    .foregroundColor(.appPrimaryText)
                Text(payment.status.label)
                    .font(.csClarity(.regular, size: 14))
                    .foregroundColor(.appSecondaryText)
            }
            Spacer()
            // The chevron is hidden on "no data" rows (matches the Figma).
            if payment.status != .noData {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.appSecondaryText)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 76)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(payment.status.rowBackground)
        )
        .shadow(color: payment.status == .noData ? Color.clear : .appShadow,
                radius: 8, x: 0, y: 2)
    }

    private var statusBadge: some View {
        ZStack {
            Circle()
                .fill(payment.status.badgeBackground)
            Image(payment.status.iconName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundColor(payment.status.badgeForeground)
        }
        .frame(width: 36, height: 36)
    }
}

#Preview {
    VStack(spacing: 12) {
        PaymentRowView(payment: Payment(month: "August", year: 2026, status: .confirmed))
        PaymentRowView(payment: Payment(month: "May", year: 2026, status: .unconfirmed))
        PaymentRowView(payment: Payment(month: "January", year: 2026, status: .noData))
    }
    .padding()
    .background(Color.appBackground)
}
