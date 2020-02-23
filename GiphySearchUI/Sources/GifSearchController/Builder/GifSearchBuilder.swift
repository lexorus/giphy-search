import Foundation

public final class GifSearchBuilder {
    public static func build(gifResultsFetcher: GifSearchResultsFetcher,
                             gifDataProvider: @escaping GifDataProvider,
                             onGifSelected: @escaping (String) -> Void) -> GifSearchViewController {
        let vc = GifSearchViewController.instantiate()
        let presenter = GifSearchPresenter(view: vc,
                                           gifResultsFetcher: gifResultsFetcher,
                                           gifDataProvider: gifDataProvider,
                                           onGifSelected: onGifSelected)
        vc.presenter = presenter

        return vc
    }
}
