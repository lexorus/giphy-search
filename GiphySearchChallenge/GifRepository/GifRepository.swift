import Foundation
import GifAPI
import GiphySearchUI

protocol GifRepository: GifSearchResultsFetcher {
    init(gifAPI: GifAPI)
    func getGif(for id: String) -> Gif?
    func getRandomGif(completion: @escaping (Gif) -> Void)
    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping ([(id: String, url: String)]) -> Void)
    func data(for stringURL: String, completion: @escaping (Data) -> Void)
}
