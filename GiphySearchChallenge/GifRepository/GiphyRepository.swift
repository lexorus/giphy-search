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

    func getRandomGif(completion: @escaping (Gif) -> Void) {
        gifAPI.getRandomGIF { result in
            switch result {
            case .success(let gif):
                completion(gif)
            case .failure(let error):
                print("Get random gif failed with error: \(error)")
            }
        }
    }

    func getGif(for id: String) -> Gif? {
        return gifsCache[id]
    }
}

extension GiphyRepository: GifSearchResultsFetcher {
    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping ([(id: String, url: String)]) -> Void) {
        gifAPI.searchForGifs(with: query,
                               pageSize: pageSize,
                               offset: offset) { [weak self] (result) in
                                switch result {
                                case .success(let gifs):
                                    gifs.forEach { self?.gifsCache[$0.id] = $0 }
                                    completion(gifs.map({ ($0.id, $0.stillImageURL) }))
                                case .failure(let error):
                                    print("Search request failed with error: \(error)")
                                }
        }
    }

    func data(for stringURL: String, completion: @escaping (Data) -> Void) {
        if let cachedData = dataCache.object(forKey: stringURL as NSString) {
            completion(cachedData as Data)
            return
        }
        gifAPI.getData(for: stringURL) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataCache.setObject(data as NSData, forKey: stringURL as NSString)
                completion(data)
            case .failure(let error):
                print("Get data request failed with error: \(error)")
            }
        }
    }
}
