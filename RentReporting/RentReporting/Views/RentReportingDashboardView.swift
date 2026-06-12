import SwiftUI

struct RentReportingDashboardView: View {
    @EnvironmentObject private var router: NavigationRouter

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    heroSection
                    latestPaymentsSection
                        .padding(.top, 24)
                    yourRentDetailsSection
                        .padding(.top, 32)
                    quickActionsSection
                        .padding(.top, 32)
                        .padding(.bottom, 24)
                }
                .padding(.bottom, 83)
            }
            .ignoresSafeArea(edges: .top)

            CustomTabBar(activeTab: "Credit Health", onHomeTapped: { router.popToRoot() })
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { dashboardToolbar }
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var dashboardToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            NavBarCircleButton(systemName: "chevron.left", action: {})
        }
        ToolbarItem(placement: .principal) {
            Text("Rent reporting")
                .font(.csClarity(.bold, size: 17))
                .foregroundColor(.appPrimaryText)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            NavBarCircleButton(systemName: "person", action: {})
            NavBarCircleButton(systemName: "bell", action: {})
        }
    }

    // MARK: - Hero
    private var heroSection: some View {
        // Figma spec: 375×335pt frame. The nav bar (≈116pt) overlaps the top portion
        // via .ignoresSafeArea(edges: .top) on the parent ScrollView; hero content is
        // pinned to the bottom 202pt, mirroring the Figma ContentContainer at y=133.
        ZStack(alignment: .bottom) {
            Image("HeroBackground")
                .resizable()
                .scaledToFill()
                .clipped()

            // Fade the bottom edge into the page background colour
            LinearGradient(
                stops: [
                    .init(color: Color.clear, location: 0.5),
                    .init(color: Color.appBackground, location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            HStack(spacing: 24) {
                Image("HeroCalendar")
                    .resizable()
                    .frame(width: 128, height: 138)
                heroNumberBlock
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 33)
        }
        .frame(height: 335)
        .frame(maxWidth: .infinity)
        .clipped()
    }

    private var heroNumberBlock: some View {
        VStack(alignment: .leading, spacing: 6) {
            // "Active" pill
            HStack(spacing: 6) {
                Circle()
                    .fill(Color(hex: "#2ECC71"))
                    .frame(width: 8, height: 8)
                Text("Active")
                    .font(.csClarity(.medium, size: 13))
                    .foregroundColor(.appPositiveText)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(
                Capsule().fill(Color.white.opacity(0.6))
            )

            Text("01")
                .font(.csClarityDisplay(size: 64))
                .foregroundColor(.appPrimaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text("Months reported")
                .font(.csClarity(.regular, size: 15))
                .foregroundColor(.appPrimaryText.opacity(0.7))
        }
    }

    // MARK: - Latest payments

    private let timelineMonths: [(abbrev: String, payment: Payment)] = [
        ("Apr", Payment(month: "April",     year: 2026, status: .confirmed)),
        ("May", Payment(month: "May",       year: 2026, status: .confirmed)),
        ("Jun", Payment(month: "June",      year: 2026, status: .confirmed)),
        ("Jul", Payment(month: "July",      year: 2026, status: .confirmed)),
        ("Aug", Payment(month: "August",    year: 2026, status: .confirmed)),
        ("Sep", Payment(month: "September", year: 2026, status: .unconfirmed)),
    ]

    private var latestPaymentsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("LATEST PAYMENTS")
                    .font(.csClarity(.medium, size: 12))
                    .foregroundColor(.appSecondaryText)
                    .tracking(0.8)
                Spacer()
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                    Text("Last updated 20 Sep")
                        .font(.csClarity(.regular, size: 12))
                }
                .foregroundColor(.appActionTeal)
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    NavigationLink(destination: AllPaymentsView()) {
                        SeeAllTileView()
                    }
                    .buttonStyle(.plain)

                    ForEach(timelineMonths, id: \.abbrev) { item in
                        NavigationLink(destination: PaymentDetailView(payment: item.payment)) {
                            TimelineTileView(
                                monthAbbreviation: item.abbrev,
                                isConfirmed: item.payment.status == .confirmed
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
            .timelineScrollAnchor()

            confirmationBanner
                .padding(.horizontal, 16)
        }
    }

    private var confirmationBanner: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.appPositiveIconBg)
                Image("icon-payment-confirmed")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.appPositiveText)
            }
            .frame(width: 24, height: 24)

            Text("Your August payment was confirmed")
                .font(.csClarity(.medium, size: 14))
                .foregroundColor(.appPrimaryText)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.appPositiveSurface)
        )
    }

    // MARK: - Your rent details
    private var yourRentDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("YOUR RENT DETAILS")
                .font(.csClarity(.medium, size: 12))
                .foregroundColor(.appSecondaryText)
                .tracking(0.8)

            Text("Your bank account")
                .font(.csClarity(.bold, size: 20))
                .foregroundColor(.appPrimaryText)

            bankAccountCard

            Text("Tenancy details")
                .font(.csClarity(.bold, size: 20))
                .foregroundColor(.appPrimaryText)
                .padding(.top, 8)

            tenancyDetailsCard
        }
        .padding(.horizontal, 16)
    }

    private var bankAccountCard: some View {
        HStack(spacing: 12) {
            // Barclays "logo" placeholder — a circular light surface with the brand glyph
            ZStack {
                Circle().fill(Color(hex: "#FFFFFF"))
                Image("icon-barclays-logomark")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 36, height: 36)

            VStack(alignment: .leading, spacing: 2) {
                Text("Barclays")
                    .font(.csClarity(.bold, size: 16))
                    .foregroundColor(.appPrimaryText)
                Text("*****678")
                    .font(.csClarity(.regular, size: 14))
                    .foregroundColor(.appSecondaryText)
            }
            Spacer()

            // "Linked" pill
            Text("Linked")
                .font(.csClarity(.medium, size: 12))
                .foregroundColor(.appPositiveText)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Capsule().fill(Color.appPositiveSurface)
                )

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.appSecondaryText)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .appShadow, radius: 8, x: 0, y: 2)
    }

    private var tenancyDetailsCard: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                // Rent amount card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Your rent is")
                        .font(.csClarity(.bold, size: 16))
                        .foregroundColor(.appPrimaryText)
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text("£")
                                .font(.csClarity(.bold, size: 16))
                                .foregroundColor(.appPrimaryText)
                            Text("1,250")
                                .font(.csClarityDisplay(size: 28))
                                .foregroundColor(.appPrimaryText)
                        }
                        Text("per month")
                            .font(.csClarity(.regular, size: 14))
                            .foregroundColor(.appPrimaryText)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white)
                )

                // Payment date card
                VStack(alignment: .leading, spacing: 0) {
                    Text("Paid on")
                        .font(.csClarity(.bold, size: 16))
                        .foregroundColor(.appPrimaryText)
                    Spacer()
                    Text("29th")
                        .font(.csClarityDisplay(size: 32))
                        .foregroundColor(.appPrimaryText)
                    Text("of every month")
                        .font(.csClarity(.regular, size: 14))
                        .foregroundColor(.appPrimaryText)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white)
                )
            }
            .fixedSize(horizontal: false, vertical: true)

            // Address card
            VStack(alignment: .leading, spacing: 4) {
                Text("Address")
                    .font(.csClarity(.bold, size: 16))
                    .foregroundColor(.appPrimaryText)
                Text("1-45 Durham Street\nSE 11 5JH")
                    .font(.csClarity(.regular, size: 14))
                    .foregroundColor(.appSecondaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white)
            )
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(hex: "#CAE4E6"))
        )
    }

    // MARK: - Quick actions
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("QUICK ACTIONS")
                .font(.csClarity(.medium, size: 12))
                .foregroundColor(.appSecondaryText)
                .tracking(0.8)

            Text("Manage your rent reporting")
                .font(.csClarity(.bold, size: 20))
                .foregroundColor(.appPrimaryText)

            // First card — three "details" rows grouped together
            VStack(spacing: 0) {
                quickActionRow(
                    icon: "icon-manage-accounts",
                    title: "Manage your accounts",
                    subtitle: "Manage your linked accounts or link a new one",
                    trailing: .chevron
                )
                actionDivider()
                quickActionRow(
                    icon: "icon-change-payment",
                    title: "Change payment details",
                    subtitle: "Update payment amount or date",
                    trailing: .chevron
                )
                actionDivider()
                quickActionRow(
                    icon: "icon-moving",
                    title: "Tell us you're moving",
                    subtitle: "Update your new details and upload your new tenancy agreement",
                    trailing: .chevron
                )
            }
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .appShadow, radius: 8, x: 0, y: 2)

            // "Get help" — its own card
            quickActionRow(
                icon: "icon-get-help",
                title: "Get help",
                subtitle: nil,
                trailing: .external
            )
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .appShadow, radius: 8, x: 0, y: 2)

            // "Stop rent reporting" — its own card
            quickActionRow(
                icon: "icon-stop-reporting",
                title: "Stop rent reporting",
                subtitle: nil,
                trailing: .chevron
            )
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .appShadow, radius: 8, x: 0, y: 2)
        }
        .padding(.horizontal, 16)
    }

    private func actionDivider() -> some View {
        Divider().padding(.leading, 56)
    }

    private enum TrailingAccessory { case chevron, external }

    private func quickActionRow(
        icon: String,
        title: String,
        subtitle: String?,
        trailing: TrailingAccessory
    ) -> some View {
        HStack(spacing: 14) {
            Image(icon)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.appPrimaryText)
                .frame(width: 28, height: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.csClarity(.bold, size: 16))
                    .foregroundColor(.appPrimaryText)
                if let subtitle {
                    Text(subtitle)
                        .font(.csClarity(.regular, size: 13))
                        .foregroundColor(.appSecondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer()
            switch trailing {
            case .chevron:
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.appSecondaryText)
            case .external:
                Image(systemName: "arrow.up.right.square")
                    .font(.system(size: 16))
                    .foregroundColor(.appSecondaryText)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}


// MARK: - Navigation bar circle button
/// Small circular surface used behind each navigation-bar icon. On iOS 26+ this uses
/// the real Liquid Glass material; on older OSes it falls back to a translucent
/// `.ultraThinMaterial` circle so the chip-style look is preserved.
struct NavBarCircleButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.appPrimaryText)
                .frame(width: 32, height: 32)
                .modifier(GlassyCircleBackground())
        }
        .buttonStyle(.plain)
    }
}

private struct GlassyCircleBackground: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffect(.regular, in: Circle())
        } else {
            content
                .background(Circle().fill(.ultraThinMaterial))
                .overlay(Circle().strokeBorder(Color.white.opacity(0.4), lineWidth: 0.5))
        }
    }
}

// MARK: - Helpers

private extension View {
    /// Anchors the horizontal scroll view to its trailing edge so the most-recent
    /// months are visible on load. Falls back gracefully on iOS 16.
    @ViewBuilder
    func timelineScrollAnchor() -> some View {
        if #available(iOS 17, *) {
            self.defaultScrollAnchor(.trailing)
        } else {
            self
        }
    }
}

#Preview {
    ContentView()
}
