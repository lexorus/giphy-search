import Foundation

public protocol GifAPI {
    init(apiKey: String)
    @discardableResult
    func getRandomGIF(completion: @escaping NetworkCompletion<Gif>) -> NetworkTask?
    @discardableResult
    func getStillImageData(for gif: Gif, completion: @escaping NetworkCompletion<Data>) -> NetworkTask?
    @discardableResult
    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping NetworkCompletion<[Gif]>)  -> NetworkTask?
    @discardableResult
    func getData(for stringURL: String, completion: @escaping NetworkCompletion<Data>) -> NetworkTask?
}
