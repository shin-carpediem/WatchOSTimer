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
            finishedButton
                .onAppear(perform: {
                    model.didTimerFinishedButtonShown()
                })
                .onDisappear(perform: {
                    model.viewDidDisAppear()
                })
        } else {
            VStack(spacing: 20) {
                progressCircleBar
                cancelButton
            }
            .padding(.top)
            .onAppear(perform: {
                model.viewDidAppear()
            })
            .onDisappear(perform: {
                model.viewDidDisAppear()
            })
        }
    }
    
    private var progressCircleBar: some View {
        ZStack {
            Text("\(model.observable.remainedSec)").font(.title2)
            
            ProgressCircleBar(total: model.selectedSec,
                              progress: model.observable.remainedSec)
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            router.path.removeLast()
        }, label: {
            Text("Cancel").font(.title3).foregroundStyle(Colors.secondary)
        })
    }
    
    private var finishedButton: some View {
        Button(action: {
            router.path.removeLast()
        }, label: {
            Text("Finished").font(.title3).foregroundStyle(Colors.primary)
        })
    }
}

// MARK: - Preview

#Preview {
    TimerView(model: TimerModel(selectedSec: 3))
}
