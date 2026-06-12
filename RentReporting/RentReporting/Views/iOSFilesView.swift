import SwiftUI

struct iOSFilesView: View {
    @State private var navigate = false

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
                Button(action: { navigate = true }) {
                    Color.clear
                        .frame(height: 120)
                }
                Spacer()
            }
        }
        .navigationDestination(isPresented: $navigate) {
            ProcessingInterstitialView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { FlowNavBar(title: "Start reporting your rent") }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack { iOSFilesView() }
}
