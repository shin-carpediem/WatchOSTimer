import SwiftUI

struct TimerView: View {
    @EnvironmentObject private var router: AppRouter
    
    var selectedSec: Int
    
    var body: some View {
        Text("\(selectedSec)")
    }
}

#Preview {
    TimerView(selectedSec: 3)
}
