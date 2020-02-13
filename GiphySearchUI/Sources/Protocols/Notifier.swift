import Foundation

protocol Notifier {
    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?)
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: Notifier {
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?) {
        addObserver(observer, selector: aSelector, name: aName, object: nil)
    }
}
