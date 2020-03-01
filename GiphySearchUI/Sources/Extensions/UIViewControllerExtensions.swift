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

    func presentErrorAlert(with message: String, onRetry: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { [weak alertController] _ in
                                            alertController?.dismiss(animated: true) }
        alertController.addAction(cancelAction)

        if let onRetry = onRetry {
            let retryAction = UIAlertAction(title: "Retry",
                                            style: .default,
                                            handler: { _ in onRetry() })
            alertController.addAction(retryAction)
        }

        present(alertController, animated: true)
    }
}
