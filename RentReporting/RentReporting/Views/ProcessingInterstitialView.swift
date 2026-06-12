import SwiftUI

struct ProcessingInterstitialView: View {
    enum ProcessingState {
        case verifying, settingUp, allDone
    }

    @EnvironmentObject private var router: NavigationRouter
    @State private var currentState: ProcessingState = .verifying

    var body: some View {
        ZStack {
            // Dark background
            LinearGradient(
                colors: [Color(hex: "#1A2E2F"), Color(hex: "#0C1E29")],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            // Tint overlay
            Color(hex: "#346A6E").opacity(0.08).ignoresSafeArea()

            VStack {
                Spacer()

                // Arc section
                ZStack(alignment: .bottom) {
                    if let arcImage = UIImage(named: "ProcessingArcLine") {
                        Image(uiImage: arcImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .opacity(0.9)
                    } else {
                        Canvas { context, size in
                            let path = Path { p in
                                p.move(to: CGPoint(x: 0, y: size.height * 0.6))
                                p.addCurve(
                                    to: CGPoint(x: size.width, y: size.height * 0.6),
                                    control1: CGPoint(x: size.width * 0.25, y: -size.height * 0.5),
                                    control2: CGPoint(x: size.width * 0.75, y: -size.height * 0.5)
                                )
                            }
                            context.stroke(path, with: .color(Color(hex: "#18D9BF")), lineWidth: 3)
                        }
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 120)
                .frame(maxWidth: .infinity)

                // Content area with blur
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text(titleText)
                            .font(.csClarity(.bold, size: 28))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .animation(.easeInOut, value: currentState)

                        Text(subtitleText)
                            .font(.csClarity(.regular, size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .animation(.easeInOut, value: currentState)
                    }
                    .padding(.horizontal, 16)

                    continueButton
                        .padding(.horizontal, 26)
                }
                .padding(.vertical, 32)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial.opacity(0.6))

                Spacer(minLength: 0)
                    .frame(height: 34)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear { startProgression() }
    }

    private var titleText: String {
        switch currentState {
        case .verifying: return "Verifying your tenancy"
        case .settingUp: return "Setting up your dashboard"
        case .allDone: return "All done"
        }
    }

    private var subtitleText: String {
        switch currentState {
        case .verifying, .settingUp: return "This could take a few seconds"
        case .allDone: return "You're all set, check out your Rent reporting dashboard"
        }
    }

    @ViewBuilder
    private var continueButton: some View {
        switch currentState {
        case .verifying, .settingUp:
            Text("Continue")
                .font(.csClarity(.bold, size: 16))
                .foregroundColor(Color.white.opacity(0.32))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.16))
                )
        case .allDone:
            Button(action: { router.path.append(Route.dashboard) }) {
                Text("See dashboard")
                    .font(.csClarity(.bold, size: 16))
                    .foregroundColor(Color(hex: "#1F4043"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(hex: "#B4F7EE"))
                    )
            }
        }
    }

    private func startProgression() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: 0.5)) { currentState = .settingUp }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut(duration: 0.5)) { currentState = .allDone }
            }
        }
    }
}

#Preview {
    ContentView()
}
