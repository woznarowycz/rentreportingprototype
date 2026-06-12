import SwiftUI

enum Route: Hashable {
    case selectAccount
    case uploadTenancy
    case iOSFiles
    case processingInterstitial
    case dashboard
}

final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()

    func popToRoot() {
        path.removeLast(path.count)
    }
}
