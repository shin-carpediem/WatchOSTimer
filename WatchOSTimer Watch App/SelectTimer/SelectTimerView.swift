import SwiftUI

struct SelectTimerView: View {
    @EnvironmentObject private var router: AppRouter
    @State var observable = Observable()
    
    @Observable final class Observable {
        var selectedSec = 3
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                titleLabel
                picker
                startTimerButton
            }
            .navigationDestination(for: NavigationDestination.self) {
                designatedRoute($0)
            }
        }
    }
    
    private var titleLabel: some View {
        Text("Timer \(observable.selectedSec) seconds").font(.body)
    }
    
    private var picker: some View {
        let secList = [3, 5, 10, 30, 60]
        return Picker(selection: $observable.selectedSec) {
            ForEach(secList, id: \.self) { sec in
                Text("\(sec)").tag(sec).font(.title2)
            }
        } label: { Text("") }
    }
    
    private var startTimerButton: some View {
        NavigationLink(value: NavigationDestination.timerView) {
            Label("Start", systemImage: "timer")
        }
    }
}

// MARK: - Routing

extension SelectTimerView {
    private func designatedRoute(_ destination: NavigationDestination) -> some View {
        switch destination {
        case .selectTimerView:
            fatalError()
            
        case .timerView:
            let model = TimerModel()
            model.observable.selectedSec = observable.selectedSec
            let view = TimerView(model: model)
            return view
        }
    }
}

// MARK: - Preview

#Preview {
    SelectTimerView()
}
