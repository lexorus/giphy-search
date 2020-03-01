import Foundation

public final class GifSearchResultsBuilder {
    public static func build(queryProvider: GifSearchQueryProvider,
                             fetcher: GifSearchResultsFetcher,
                             onGifSelected: @escaping (String) -> Void) -> GifSearchResultsViewController {
        let vc = GifSearchResultsViewController.instantiate()
        let presenter = GifSearchResultsPresenter(view: vc,
                                                  queryProvider: queryProvider,
                                                  fetcher: fetcher,
                                                  onGifSelected: onGifSelected)
        vc.presenter = presenter

        return vc
    }
}
