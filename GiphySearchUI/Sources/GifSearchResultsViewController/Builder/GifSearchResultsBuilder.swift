import Foundation

public final class GifSearchResultsBuilder {
    public static func build(queryProvider: GifSearchQueryProvider,
                             fetcher: GifSearchResultsFetcher,
                             onGifSelected: @escaping (String) -> Void) -> GifSearchResultsViewController {
        let viewController = GifSearchResultsViewController.instantiate()
        let presenter = GifSearchResultsPresenter(view: viewController,
                                                  queryProvider: queryProvider,
                                                  fetcher: fetcher,
                                                  onGifSelected: onGifSelected)
        viewController.presenter = presenter

        return viewController
    }
}
