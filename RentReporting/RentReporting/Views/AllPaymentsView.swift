import SwiftUI

struct AllPaymentsView: View {
    private let paymentsByYear: [(year: Int, payments: [Payment])] = [
        (
            2026,
            [
                Payment(month: "August",   year: 2026, status: .confirmed),
                Payment(month: "July",     year: 2026, status: .confirmed),
                Payment(month: "June",     year: 2026, status: .confirmed),
                Payment(month: "May",      year: 2026, status: .unconfirmed),
                Payment(month: "April",    year: 2026, status: .confirmed),
                Payment(month: "March",    year: 2026, status: .confirmed),
                Payment(month: "February", year: 2026, status: .unconfirmed),
                Payment(month: "January",  year: 2026, status: .noData)
            ]
        ),
        (
            2025,
            [
                Payment(month: "December", year: 2025, status: .noData)
            ]
        )
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: []) {
                    ForEach(paymentsByYear, id: \.year) { group in
                        Text(String(group.year))
                            .font(.csClarityDisplay(size: 32))
                            .foregroundColor(.appPrimaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                            .padding(.bottom, 12)

                        ForEach(group.payments) { payment in
                            if payment.status == .noData {
                                // No-data rows are non-interactive in the Figma.
                                PaymentRowView(payment: payment)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                            } else {
                                NavigationLink(value: payment) {
                                    PaymentRowView(payment: payment)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 6)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.bottom, 83 + 16)
            }

            CustomTabBar(activeTab: "Home")
        }
        .navigationDestination(for: Payment.self) { payment in
            PaymentDetailView(payment: payment)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { allPaymentsToolbar }
        // Native iOS nav bar appearance (Liquid Glass on iOS 26+).
        .navigationBarTitleDisplayMode(.inline)
    }

    @Environment(\.dismiss) private var dismiss

    @ToolbarContentBuilder
    private var allPaymentsToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            NavBarCircleButton(systemName: "chevron.left", action: { dismiss() })
        }
        ToolbarItem(placement: .principal) {
            Text("All payments")
                .font(.csClarity(.bold, size: 17))
                .foregroundColor(.appPrimaryText)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            NavBarCircleButton(systemName: "bell", action: {})
            NavBarCircleButton(systemName: "person", action: {})
        }
    }
}

#Preview {
    NavigationStack {
        AllPaymentsView()
    }
}
