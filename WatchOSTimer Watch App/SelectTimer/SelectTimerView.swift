import SwiftUI

private enum NavigationDestination: Hashable {
    case timerView
}

struct SelectTimerView: View {
    @EnvironmentObject private var router: AppRouter

    @State private var observable = Observable()
    
    @Observable fileprivate final class Observable {
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
}

private extension SelectTimerView {
    func designatedRoute(_ destination: NavigationDestination) -> some View {
        switch destination {
        case .timerView:
            TimerView(selectedSec: observable.selectedSec)
        }
    }
}

private extension SelectTimerView {
    var titleLabel: some View {
        Text("Timer \(observable.selectedSec) seconds")
            .font(.body)
    }
    
    var picker: some View {
        let secList = [3, 5, 10, 30, 60]
        return Picker(selection: $observable.selectedSec) {
            ForEach(secList, id: \.self) { sec in
                Text("\(sec)").tag(sec).font(.title2)
            }
        } label: { Text("") }
    }
    
    var startTimerButton: some View {
        NavigationLink(value: NavigationDestination.timerView) {
            Text("Set")
        }
    }
}

#Preview {
    SelectTimerView()
}
