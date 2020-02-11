import Foundation

public protocol GifAPI {
    init(apiKey: String)
    func getRandomGIF(completion: @escaping NetworkCompletion<Gif>) -> NetworkTask?
    func getStillImageData(for gif: Gif, completion: @escaping NetworkCompletion<Data>) -> NetworkTask?
    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping NetworkCompletion<[Gif]>)  -> NetworkTask?
}
