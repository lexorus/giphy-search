import Foundation
import GifAPI
import GiphySearchUI

protocol GifRepository: GifSearchResultsFetcher {
    init(gifAPI: GifAPI)
    func getGif(for id: String) -> Gif?
    func getRandomGif(completion: @escaping (Result<Gif, FetchingError>) -> Void) -> Cancellable?
}
