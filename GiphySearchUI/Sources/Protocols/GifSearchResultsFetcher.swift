import Foundation

public protocol GifSearchResultsFetcher {
    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping (Result<[(id: String, url: String)], FetchingError>) -> Void)
    func data(for stringURL: String, completion: @escaping (Result<Data, FetchingError>) -> Void)
}
