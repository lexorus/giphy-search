import Foundation

func onMain(_ action: @escaping () -> Void) {
    DispatchQueue.main.async { action() }
}
