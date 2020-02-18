import Foundation

final class GifSearchBuilder {
    static func build() -> GifSearchViewController {
        let vc = GifSearchViewController.instantiate()
        let presenter = GifSearchPresenter(view: vc)
        vc.presenter = presenter

        return vc
    }
}
