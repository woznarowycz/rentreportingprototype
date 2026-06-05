import SwiftUI

struct PaymentDetailView: View {
    let payment: Payment

    init(payment: Payment = Payment(month: "August", year: 2025, status: .confirmed)) {
        self.payment = payment
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(payment.monthYearTitle)
                        .font(.csClarityDisplay(size: 32))
                        .foregroundColor(.appPrimaryText)
                        .padding(.top, 16)

                    statusBadge
                        .padding(.top, 8)

                    Text("Rent payment: \(payment.status.label)")
                        .font(.csClarity(.bold, size: 20))
                        .foregroundColor(.appPrimaryText)
                        .padding(.top, 4)

                    statusBody
                        .lineSpacing(2)

                    Text("ABOUT THIS RENT PAYMENT")
                        .font(.csClarity(.medium, size: 12))
                        .foregroundColor(.appSecondaryText)
                        .tracking(0.8)
                        .padding(.top, 24)

                    Text("Payment details")
                        .font(.csClarity(.bold, size: 20))
                        .foregroundColor(.appPrimaryText)

                    paymentDetailsCard
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 83 + 16)
            }

            CustomTabBar(activeTab: "Home")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { detailToolbar }
        // Native iOS nav bar appearance (Liquid Glass on iOS 26+).
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Toolbar
    @Environment(\.dismiss) private var dismiss

    @ToolbarContentBuilder
    private var detailToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            NavBarCircleButton(systemName: "chevron.left", action: { dismiss() })
        }
        ToolbarItem(placement: .principal) {
            Text("Payment details")
                .font(.csClarity(.bold, size: 17))
                .foregroundColor(.appPrimaryText)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            NavBarCircleButton(systemName: "person", action: {})
            NavBarCircleButton(systemName: "bell", action: {})
        }
    }

    // MARK: - Status badge (~32×32, light fill + dark icon)
    private var statusBadge: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(payment.status.badgeBackground)
            Image(payment.status.iconName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .foregroundColor(payment.status.badgeForeground)
        }
        .frame(width: 32, height: 32)
    }

    // MARK: - Status body copy
    private var statusBody: some View {
        let monthName = payment.month
        switch payment.status {
        case .confirmed:
            return Text("Your \(monthName) payment was reported to the bureaus and will ")
                .font(.csClarity(.regular, size: 15))
                .foregroundColor(.appPrimaryText)
            + Text("appear in your credit report in 4-8 weeks")
                .font(.csClarity(.bold, size: 15))
                .foregroundColor(.appPrimaryText)
        case .unconfirmed:
            return Text("We couldn't confirm your \(monthName) payment yet. ")
                .font(.csClarity(.regular, size: 15))
                .foregroundColor(.appPrimaryText)
            + Text("We'll keep trying and update you once it's confirmed.")
                .font(.csClarity(.bold, size: 15))
                .foregroundColor(.appPrimaryText)
        case .noData:
            return Text("We don't have any data for your \(monthName) payment. ")
                .font(.csClarity(.regular, size: 15))
                .foregroundColor(.appPrimaryText)
            + Text("Check that your bank account is still linked.")
                .font(.csClarity(.bold, size: 15))
                .foregroundColor(.appPrimaryText)
        }
    }

    // MARK: - Payment details card
    private var paymentDetailsCard: some View {
        VStack(spacing: 0) {
            DetailRowView(label: "Payment amount", value: "£1,250")
            Divider()
            DetailRowView(label: "Date", value: "29 \(payment.month) \(payment.year)")
            Divider()
            DetailRowView(
                label: "Address",
                value: "1-45 Durham Street\nSE 11 5JH",
                allowsMultilineValue: true
            )
            Divider()
            DetailRowView(label: "Bank account", value: "Barclays *****678")
        }
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .appShadow, radius: 8, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        PaymentDetailView()
    }
}
