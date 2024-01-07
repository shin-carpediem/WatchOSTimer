import SwiftUI

protocol TimerModelProtocol: AnyObject {
    var observable: TimerModel.Observable { get }
    func viewDidAppear()
    func viewDidDisAppear()
    func didTimerFinishedButtonShown()
}

final class TimerModel: TimerModelProtocol {
    // MARK: - TimerModelProtocol
    
    @State var observable = Observable()
    
    @Observable final class Observable {
        var showTimerFinishButton = false
        var selectedSec = 3
    }
    
    func viewDidAppear() {
        Timer.scheduledTimer(withTimeInterval: 1.0,
                             repeats: true) { [weak self] _ in
            guard let self else { return }
            if observable.selectedSec >= resetTime {
                observable.selectedSec -= 1
            }
            observable.showTimerFinishButton = observable.selectedSec <= resetTime
        }
    }
    
    func viewDidDisAppear() {
        Timer.cancelPreviousPerformRequests(withTarget: self)
    }
    
    func didTimerFinishedButtonShown() {
        WKInterfaceDevice.current().play(.notification)
    }
    
    // MARK: - Private
    
    private let resetTime = 0
}
