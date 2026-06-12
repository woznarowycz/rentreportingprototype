import SwiftUI

struct SelectAccountView: View {
    @State private var selectedAccount = "NatWest"

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(hex: "#E5F2F3").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    HeroArcHeaderView(activeMilestones: 1)
                        .frame(height: 178)

                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What bank account do you use to pay your rent?")
                                .font(.csClarity(.bold, size: 28))
                                .foregroundColor(Color(hex: "#263648"))
                            Text("We'll automatically detect your rent payment from this account every month")
                                .font(.csClarity(.regular, size: 16))
                                .foregroundColor(.appPrimaryText)
                        }
                        .padding(.horizontal, 8)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Choose the account you pay rent from")
                                .font(.csClarity(.bold, size: 16))
                                .foregroundColor(.appPrimaryText)
                            accountOption(name: "NatWest", maskedNumber: "*****678", isSelected: selectedAccount == "NatWest") {
                                selectedAccount = "NatWest"
                            }
                            accountOption(name: "Barclays", maskedNumber: "*****678", isSelected: selectedAccount == "Barclays") {
                                selectedAccount = "Barclays"
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("OTHER ACCOUNTS")
                                .font(.csClarity(.medium, size: 12))
                                .foregroundColor(Color(hex: "#263648"))
                                .tracking(0.48)
                                .padding(.horizontal, 8)
                            accountOption(name: "HSBC", maskedNumber: "*****678", isSelected: selectedAccount == "HSBC") {
                                selectedAccount = "HSBC"
                            }
                        }

                        Button(action: {}) {
                            Text("Link a different account")
                                .font(.csClarity(.bold, size: 16))
                                .foregroundColor(.appActionTeal)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 140)
                }
            }

            VStack(spacing: 8) {
                NavigationLink(destination: UploadTenancyView()) {
                    Text("Next")
                        .font(.csClarity(.bold, size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "#275053"), Color(hex: "#0F2533")],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        )
                }
                .buttonStyle(.plain)

                Button(action: {}) {
                    Text("Cancel rent reporting")
                        .font(.csClarity(.bold, size: 16))
                        .foregroundColor(.appActionTeal)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 34)
            .background(Color(hex: "#E5F2F3").ignoresSafeArea(edges: .bottom))
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { FlowNavBar(title: "Start reporting your rent") }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }

    private func accountOption(name: String, maskedNumber: String, isSelected: Bool, onTap: @escaping () -> Void) -> some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.white.opacity(0.3) : Color(hex: "#D9DFE5"))
                        .frame(width: 24, height: 24)
                    Circle()
                        .strokeBorder(isSelected ? Color.white : Color(hex: "#346A6E"), lineWidth: 2)
                        .frame(width: 24, height: 24)
                    if isSelected {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 10, height: 10)
                    }
                }

                Circle()
                    .fill(bankColor(for: name))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Text(name.prefix(1))
                            .font(.csClarity(.bold, size: 10))
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.csClarity(.regular, size: 16))
                        .foregroundColor(isSelected ? .white : .appPrimaryText)
                    Text(maskedNumber)
                        .font(.csClarity(.regular, size: 12))
                        .foregroundColor(isSelected ? Color.white.opacity(0.7) : .appSecondaryText)
                        .tracking(0.48)
                }
                Spacer()
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(isSelected ? Color(hex: "#2D719B") : Color.white)
                    .shadow(color: isSelected ? Color.clear : .appShadow, radius: 4, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }

    private func bankColor(for name: String) -> Color {
        switch name {
        case "NatWest": return Color(hex: "#41145E")
        case "Barclays": return Color(hex: "#00AEEF")
        case "HSBC": return Color(hex: "#DB0011")
        default: return Color.appActionTeal
        }
    }
}

#Preview {
    NavigationStack { SelectAccountView() }
}
