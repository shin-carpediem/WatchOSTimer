import SwiftUI

struct TimerView: View {
    @EnvironmentObject private var router: AppRouter
    
    @State var observable = Observable()
    
    @Observable final class Observable {
        var selectedSec = 3
    }
    
    private let resetTime = 0
    
    var body: some View {
        if observable.selectedSec >= resetTime {
            timerLabel
                .padding(.top)
                .onAppear(perform: { countDown() })
        } else {
            finishTimerButton
                .onAppear(perform: { notify() })
        }
    }
    
    private var timerLabel: some View {
        VStack {
            Text("\(observable.selectedSec)").font(.body)
        }
    }
    
    private var finishTimerButton: some View {
        Button(action: {
            router.path.removeLast()
        }, label: {
            Text("Finished").font(.title2).foregroundStyle(.cyan)
        })
    }
}

extension TimerView {
    private func countDown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if observable.selectedSec >= resetTime {
                observable.selectedSec -= 1
            }
        }
    }
    
    private func notify() {
        WKInterfaceDevice.current().play(.notification)
    }
}

#Preview {
    TimerView()
}
