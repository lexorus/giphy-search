import Foundation
import GifAPI
import GiphySearchUI

final class GiphyRepository: GifRepository {
    private let gifAPI: GifAPI
    private var gifsCache: [String: Gif] = [:]
    private var dataCache: NSCache<NSString, NSData> = .init()

    init(gifAPI: GifAPI) {
        self.gifAPI = gifAPI
    }

    func getRandomGif(completion: @escaping (Result<Gif, FetchingError>) -> Void) -> Cancellable? {
        return gifAPI.getRandomGIF { result in
            switch result {
            case .success(let gif):
                completion(.success(gif))
            case .failure(let error):
                completion(.failure(error.description))
            }
        }?.toCancellableTask()
    }

    func getGif(for id: String) -> Gif? {
        return gifsCache[id]
    }
}

extension GiphyRepository: GifSearchResultsFetcher {
    func searchForGifs( with query: String,
                        pageSize: UInt,
                        offset: UInt,
                        completion: @escaping (Result<[(id: String, url: String)], FetchingError>) -> Void)
        -> Cancellable? {
            return gifAPI.searchForGifs(with: query,
                                        pageSize: pageSize,
                                        offset: offset) { [weak self] (result) in
                                            switch result {
                                            case .success(let gifs):
                                                gifs.forEach { self?.gifsCache[$0.id] = $0 }
                                                completion(.success(gifs.map({ ($0.id, $0.stillImageURL) })))
                                            case .failure(let error):
                                                completion(.failure(error.description))
                                            }
                }?.toCancellableTask()
    }

    func data(for stringURL: String, completion: @escaping (Result<Data, FetchingError>) -> Void) -> Cancellable? {
        if let cachedData = dataCache.object(forKey: stringURL as NSString) {
            completion(.success(cachedData as Data))
            return nil
        }
        return gifAPI.getData(for: stringURL) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataCache.setObject(data as NSData, forKey: stringURL as NSString)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.description))
            }
        }?.toCancellableTask()
    }
}
