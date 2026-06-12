import SwiftUI

struct ContentView: View {
    @StateObject private var router = NavigationRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .selectAccount:        SelectAccountView()
                    case .uploadTenancy:        UploadTenancyView()
                    case .iOSFiles:             iOSFilesView()
                    case .processingInterstitial: ProcessingInterstitialView()
                    case .dashboard:            RentReportingDashboardView()
                    }
                }
        }
        .tint(.appAccent)
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
