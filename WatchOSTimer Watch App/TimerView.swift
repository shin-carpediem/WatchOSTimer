import SwiftUI

struct TimerView: View {
    @Binding var timerScreenShow: Bool
    @State var timeVal: Int
    
    var body: some View {
        Text("\(timeVal)")
    }
}

#Preview {
    TimerView(timerScreenShow: .constant(true),
              timeVal: 1)
}
