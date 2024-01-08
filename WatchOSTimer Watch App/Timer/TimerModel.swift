import SwiftUI

protocol TimerModelProtocol: AnyObject {
    var selectedSec: Int { get }
    var observable: TimerModel.Observable { get }
    func viewDidAppear()
    func viewDidDisAppear()
    func didTimerFinishedButtonShown()
}

final class TimerModel: TimerModelProtocol {
    init(selectedSec: Int) {
        self.selectedSec = selectedSec
        self.observable.remainedSec = selectedSec
    }
    
    // MARK: - TimerModelProtocol
    
    private(set) var selectedSec: Int
    @State private(set) var observable = Observable()
    
    @Observable final class Observable {
        var showTimerFinishButton = false
        var remainedSec = 3
    }
    
    func viewDidAppear() {
        startTimer()
    }
    
    func viewDidDisAppear() {
        timer?.invalidate()
    }
    
    func didTimerFinishedButtonShown() {
        WKInterfaceDevice.current().play(.notification)
    }
    
    // MARK: - Private

    private var timer: Timer?
    private let resetTime = 0
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0,
                             repeats: true) { [weak self] timer in
            guard let self else { return }
            self.timer = timer
            if observable.remainedSec >= resetTime {
                observable.remainedSec -= 1
            }
            observable.showTimerFinishButton = observable.remainedSec <= resetTime
        }
    }
}
