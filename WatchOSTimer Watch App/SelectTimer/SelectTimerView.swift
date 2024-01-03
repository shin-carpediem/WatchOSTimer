import SwiftUI

enum NavigationDestination: Hashable {
    case timerView
}

struct SelectTimerView: View {
    @EnvironmentObject private var router: AppRouter

    @State private var observable = Observable()
    
    @Observable final class Observable {
        var viewPath = [NavigationDestination]()
        var selectedSec = 3
    }
    
    var body: some View {
        NavigationStack(path: $observable.viewPath) {
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
        Text("Timer \(observable.selectedSec) seconds")
            .font(.body)
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

private extension SelectTimerView {
    func designatedRoute(_ destination: NavigationDestination) -> some View {
        switch destination {
        case .timerView:
            TimerView(selectedSec: observable.selectedSec)
        }
    }
}

#Preview {
    SelectTimerView()
}
