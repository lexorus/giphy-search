import Foundation

public typealias GifSearchQueryProvider = (@escaping (String) -> Void) -> Void

public protocol GifSearchResultsFetcher {
    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping ([String]) -> Void)
    func data(for stringURL: String, completion: @escaping (Data) -> Void)
}

public final class GifSearchResultsBuilder {
    public static func build(queryProvider: GifSearchQueryProvider,
                             fetcher: GifSearchResultsFetcher) -> GifSearchResultsViewController {
        let vc = GifSearchResultsViewController.instantiate()
        let presenter = GifSearchResultsPresenter(view: vc,
                                                  queryProvider: queryProvider,
                                                  fetcher: fetcher)
        vc.presenter = presenter

        return vc
    }
}
