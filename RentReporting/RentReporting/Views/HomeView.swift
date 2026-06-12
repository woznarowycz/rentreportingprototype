import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    circularHeroSection
                    latestUpdatesSection
                        .padding(.top, 24)
                    merchandisingCard
                        .padding(.top, 24)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                }
                .padding(.bottom, 83)
            }
            .ignoresSafeArea(edges: .top)
            CustomTabBar(activeTab: "Credit Health")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { homeToolbar }
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ToolbarContentBuilder
    private var homeToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            NavBarCircleButton(systemName: "person", action: {})
            NavBarCircleButton(systemName: "bell", action: {})
        }
    }

    // MARK: - Circular hero

    private var circularHeroSection: some View {
        ZStack(alignment: .bottom) {
            Image("HeroBackground")
                .resizable()
                .scaledToFill()
                .clipped()
            LinearGradient(
                stops: [
                    .init(color: Color.clear, location: 0.4),
                    .init(color: Color.appBackground, location: 1.0)
                ],
                startPoint: .top, endPoint: .bottom
            )
            VStack(spacing: 24) {
                Spacer()
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 280, height: 280)
                        .overlay(Circle().strokeBorder(Color.white.opacity(0.2), lineWidth: 1))
                    VStack(spacing: 8) {
                        Text("WEEKLY CHECKS")
                            .font(.csClarity(.medium, size: 12))
                            .foregroundColor(.white)
                            .tracking(0.5)
                        Text("We're searching\nfor your report")
                            .font(.csClarity(.bold, size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Capsule()
                            .fill(Color(hex: "#B4F7EE"))
                            .frame(width: 120, height: 28)
                            .overlay(
                                HStack(spacing: 4) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 11, weight: .semibold))
                                    Text("Learn more")
                                        .font(.csClarity(.medium, size: 12))
                                }
                                .foregroundColor(Color(hex: "#0C1E29"))
                            )
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .frame(height: 380)
        .frame(maxWidth: .infinity)
        .clipped()
    }

    // MARK: - Latest updates

    private var latestUpdatesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Latest updates")
                    .font(.csClarity(.bold, size: 20))
                    .foregroundColor(.appPrimaryText)
                Spacer()
                Text("See all")
                    .font(.csClarity(.bold, size: 16))
                    .foregroundColor(.appActionTeal)
            }
            .padding(.horizontal, 16)

            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    Capsule()
                        .fill(Color(hex: "#B8BDEA"))
                        .frame(width: 80, height: 24)
                        .overlay(
                            HStack(spacing: 4) {
                                Image(systemName: "star")
                                    .font(.system(size: 10))
                                Text("Welcome")
                                    .font(.csClarity(.regular, size: 12))
                                    .tracking(0.4)
                            }
                            .foregroundColor(Color(hex: "#3D49A6"))
                        )
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("We're waiting for your Equifax report")
                        .font(.csClarity(.bold, size: 16))
                        .foregroundColor(.appPrimaryText)
                    Text("Check out what you can do while you wait")
                        .font(.csClarity(.regular, size: 14))
                        .foregroundColor(.appSecondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: .appShadow, radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal, 16)

            Button(action: {}) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.down.circle")
                        .font(.system(size: 16))
                    Text("Show 3 more")
                        .font(.csClarity(.bold, size: 16))
                }
                .foregroundColor(.appActionTeal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
        }
    }

    // MARK: - Merchandising card

    private var merchandisingCard: some View {
        NavigationLink(value: Route.selectAccount) {
            VStack(alignment: .leading, spacing: 0) {
                // Dark top section
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color(hex: "#0C1E29"))
                    LinearGradient(
                        colors: [Color(hex: "#346A6E").opacity(0.6), Color.clear],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                }
                .frame(height: 100)

                // Card text area
                VStack(alignment: .leading, spacing: 12) {
                    Text("Start building your credit history using your rent")
                        .font(.csClarityDisplay(size: 22))
                        .foregroundColor(Color(hex: "#E5F2F3"))
                        .fixedSize(horizontal: false, vertical: true)

                    Text("No credit report yet? No problem. Reporting your rent to credit reference agencies can help")
                        .font(.csClarity(.regular, size: 14))
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 8) {
                        bulletItem("Use a payment you make regularly, no extra effort")
                        bulletItem("Demonstrate your reliability over time")
                        bulletItem("And it's free")
                    }

                    Text("Find out more")
                        .font(.csClarity(.bold, size: 14))
                        .foregroundColor(Color(hex: "#7BBCC1"))
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                .background(
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .fill(Color(hex: "#0C1E29"))
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            .shadow(color: Color(hex: "#96CACD").opacity(0.64), radius: 24, x: 0, y: 16)
        }
        .buttonStyle(.plain)
    }

    private func bulletItem(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(hex: "#B4F7EE"))
                .frame(width: 20)
            Text(text)
                .font(.csClarity(.regular, size: 14))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
