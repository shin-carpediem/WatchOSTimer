import SwiftUI

@main
struct WatchOSTimer_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            SelectTimerView()
                .environmentObject(AppRouter())
        }
    }
}
