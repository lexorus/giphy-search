import UIKit

extension UIViewController {
    func addChildViewController(_ child: UIViewController, into view: UIView) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            child.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        child.didMove(toParent: self)
    }
}
