import Foundation

public typealias GifSearchQueryProvider = (@escaping (String) -> Void) -> Void

public protocol GifSearchResultsFetcher {
    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping ([(id: String, url: String)]) -> Void)
    func data(for stringURL: String, completion: @escaping (Data) -> Void)
}

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
