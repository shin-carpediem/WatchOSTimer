import SwiftUI

struct ContentView: View {
    @State private var timeVal = 1
    @State private var timerScreenShow = false
    
    var body: some View {
        VStack {
            titleLabel
            picker
            
            navigation
        }
    }
    
    private var titleLabel: some View {
        Text("Timer \(timeVal) seconds")
            .font(.body)
    }
    
    private var picker: some View {
        let secList = [1, 5, 10, 30, 60]
        return Picker(selection: $timeVal) {
            ForEach(secList, id: \.self) { sec in
                Text("\(sec)").tag(sec).font(.title2)
            }
        } label: {
            Text("")
        }
    }
    
    private var navigation: some View {
        NavigationLink(
            destination: TimerView(timerScreenShow: $timerScreenShow,
                                   timeVal: timeVal),
            isActive: $timerScreenShow
        ) {
            Text("Start")
        }
    }
}

#Preview {
    ContentView()
}
