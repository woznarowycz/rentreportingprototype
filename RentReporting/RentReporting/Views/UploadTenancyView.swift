import SwiftUI

struct UploadTenancyView: View {
    @State private var consentGiven = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(hex: "#E5F2F3").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    HeroArcHeaderView(activeMilestones: 2)
                        .frame(height: 178)

                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Upload your tenancy agreement")
                                .font(.csClarity(.bold, size: 28))
                                .foregroundColor(.appPrimaryText)
                            Text("We need to verify your tenancy agreement so we can report your rent payments to the credit reference agencies")
                                .font(.csClarity(.regular, size: 16))
                                .foregroundColor(.appPrimaryText)
                        }
                        .padding(.horizontal, 8)

                        // Upload file card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 12) {
                                Image(systemName: "arrow.up.to.line")
                                    .font(.system(size: 28))
                                    .foregroundColor(.appActionTeal)
                                    .frame(width: 32, height: 32)
                                Spacer()
                            }
                            Text("Upload file")
                                .font(.csClarity(.bold, size: 16))
                                .foregroundColor(.appPrimaryText)
                            Text("File must be PDF format under XXMB")
                                .font(.csClarity(.regular, size: 14))
                                .foregroundColor(.appPrimaryText)

                            NavigationLink(value: Route.iOSFiles) {
                                Text("Select file")
                                    .font(.csClarity(.bold, size: 16))
                                    .foregroundColor(.appActionTeal)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 13)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .fill(Color(hex: "#E5F2F3"))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                    .strokeBorder(Color.appActionTeal, lineWidth: 1)
                                            )
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .fill(Color(hex: "#E5F2F3"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .strokeBorder(Color.appActionTeal, lineWidth: 1)
                                )
                        )

                        // Consent toggle
                        HStack(alignment: .top, spacing: 16) {
                            Text("My tenancy agreement includes personal information of other people. I confirm I have their consent to share this with ClearScore")
                                .font(.csClarity(.regular, size: 14))
                                .foregroundColor(.appPrimaryText)
                                .fixedSize(horizontal: false, vertical: true)
                            Toggle("", isOn: $consentGiven)
                                .labelsHidden()
                                .tint(.appActionTeal)
                        }
                        .padding(.vertical, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 160)
                }
            }

            VStack(spacing: 8) {
                NavigationLink(value: Route.processingInterstitial) {
                    Text("Upload")
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
}

#Preview {
    ContentView()
}
