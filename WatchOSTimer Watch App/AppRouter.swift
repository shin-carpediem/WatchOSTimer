import SwiftUI

final class AppRouter: ObservableObject {
    @Published var path = [NavigationDestination]()
}

enum NavigationDestination: Hashable {
    case selectTimerView
    case timerView
}
