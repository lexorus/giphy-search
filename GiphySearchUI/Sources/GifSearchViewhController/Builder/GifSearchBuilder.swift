import Foundation

public final class GifSearchBuilder {
    public static func build(gifResultsFetcher: GifSearchResultsFetcher,
                             gifDataProvider: @escaping GifDataProvider,
                             onGifSelected: @escaping (String) -> Void) -> GifSearchViewController {
        let viewController = GifSearchViewController.instantiate()
        let presenter = GifSearchPresenter(view: viewController,
                                           gifResultsFetcher: gifResultsFetcher,
                                           gifDataProvider: gifDataProvider,
                                           onGifSelected: onGifSelected)
        viewController.presenter = presenter

        return viewController
    }
}
