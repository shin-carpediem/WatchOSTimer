import SwiftUI

struct TimerView: View {
    init(model: TimerModelProtocol) {
        self.model = model
    }
    
    private let model: any TimerModelProtocol
    @EnvironmentObject private var router: AppRouter
    
    // MARK: - View
    
    var body: some View {
        if model.observable.showTimerFinishButton {
            timerFinishedButton
                .onAppear(perform: {
                    model.didTimerFinishedButtonShown()
                })
                .onDisappear(perform: {
                    model.viewDidDisAppear()
                })
        } else {
            timerLabel
                .padding(.top)
                .onAppear(perform: {
                    model.viewDidAppear()
                })
                .onDisappear(perform: {
                    model.viewDidDisAppear()
                })
        }
    }
    
    private var timerLabel: some View {
        VStack {
            Text("\(model.observable.selectedSec)").font(.body)
        }
    }
    
    private var timerFinishedButton: some View {
        Button(action: {
            router.path.removeLast()
        }, label: {
            Text("Finished").font(.title3).foregroundStyle(Colors.primary)
        })
    }
}

// MARK: - Preview

#Preview {
    TimerView(model: TimerModel())
}
