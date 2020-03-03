import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell & IdentifiableType>(_ type: T.Type) {
        register(UINib(nibName: type.identifier,
                       bundle: Bundle(for: type)),
                 forCellWithReuseIdentifier: type.identifier)
    }

    func dequeue<T: UICollectionViewCell & IdentifiableType>(_ type: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
    }
}
