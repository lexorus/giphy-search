import Foundation
@testable import GiphySearchUI

final class MockNotifier: Notifier {
    var addObserverArgs: (observer: Any, selector: Selector, name: NSNotification.Name?)?
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?) {
        addObserverArgs = (observer, aSelector, aName)
    }

    var removeObserverArgs: (Any)?
    func removeObserver(_ observer: Any) {
        removeObserverArgs = (observer)
    }
}
