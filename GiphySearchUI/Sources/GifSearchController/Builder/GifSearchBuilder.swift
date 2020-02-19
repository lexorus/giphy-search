import Foundation

public final class GifSearchBuilder {
    public static func build(gifDataProvider: @escaping GifDataProvider) -> GifSearchViewController {
        let vc = GifSearchViewController.instantiate()
        let presenter = GifSearchPresenter(view: vc, gifDataProvider: gifDataProvider)
        vc.presenter = presenter

        return vc
    }
}
