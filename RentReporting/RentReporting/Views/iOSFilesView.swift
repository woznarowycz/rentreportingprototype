import SwiftUI

struct iOSFilesView: View {
    @EnvironmentObject private var router: NavigationRouter

    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("iOSFilesScreen")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            .ignoresSafeArea()

            // Invisible tap target over the first file item area
            VStack {
                Spacer().frame(height: 200)
                Button(action: { router.path.append(Route.processingInterstitial) }) {
                    Color.clear
                        .frame(height: 120)
                }
                Spacer()
            }
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
