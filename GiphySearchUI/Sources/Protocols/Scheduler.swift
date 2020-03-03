import Foundation

protocol Scheduler {
    static func with(timeInterval: TimeInterval,
                     shouldRepeat: Bool,
                     action: @escaping (Scheduler) -> Void) -> Scheduler
    func fire()
    func invalidate()
}

extension Timer: Scheduler {
    static func with(timeInterval: TimeInterval,
                     shouldRepeat: Bool, action: @escaping (Scheduler) -> Void) -> Scheduler {
        return Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: shouldRepeat, block: action)
    }
}
