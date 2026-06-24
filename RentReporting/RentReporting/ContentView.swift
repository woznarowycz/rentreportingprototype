import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            RentReportingDashboardView()
        }
        .tint(.appAccent)
    }
}

#Preview {
    ContentView()
}
