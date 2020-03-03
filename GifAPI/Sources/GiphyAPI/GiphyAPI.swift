import Foundation

public typealias NetworkCompletion<T> = (Result<T, NetworkError>) -> Void

final public class GiphyAPI: GifAPI {
    private let network: Network
    private let requestFactory: GiphyRequestFactory

    public convenience init(apiKey: String) {
        self.init(apiKey: apiKey, network: URLSession.shared)
    }

    init(apiKey: String, network: Network) {
        self.requestFactory = GiphyRequestFactory(apiKey: apiKey)
        self.network = network
    }

    @discardableResult
    public func getRandomGIF(completion: @escaping NetworkCompletion<Gif>) -> NetworkTask? {
        guard let urlRequest = requestFactory.randomGIFURLRequest() else {
            completion(.failure(.failedToBuildURL))
            return nil
        }
        return get(from: urlRequest, completion: completion)
    }

    @discardableResult
    public func searchForGifs(with query: String,
                              pageSize: UInt,
                              offset: UInt,
                              completion: @escaping NetworkCompletion<[Gif]>) -> NetworkTask? {
        guard let urlRequest = requestFactory.searchForGifsURLRequest(query: query,
                                                                      limit: pageSize,
                                                                      offset: offset) else {
            completion(.failure(.failedToBuildURL))
            return nil
        }
        return get(from: urlRequest, completion: completion)
    }

    @discardableResult
    public func getStillImageData(for gif: Gif,
                                  completion: @escaping NetworkCompletion<Data>) -> NetworkTask? {
        guard let url = URL(string: gif.stillImageURL) else {
            completion(.failure(.failedToBuildURL))
            return nil
        }
        let urlRequest = URLRequest(url: url)

        return getData(from: urlRequest, completion: completion)
    }

    @discardableResult
    public func getData(for stringURL: String, completion: @escaping NetworkCompletion<Data>) -> NetworkTask? {
        guard let url = URL(string: stringURL) else {
            completion(.failure(.failedToBuildURL))
            return nil
        }
        let urlRequest = URLRequest(url: url)

        return getData(from: urlRequest, completion: completion)
    }

    @discardableResult
    private func get<T: Decodable & Equatable>(from urlRequest: URLRequest,
                                               completion: @escaping NetworkCompletion<T>) -> NetworkTask {
        return getData(from: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(GiphyAPIResponse<T>.self, from: data)
                    if let response = decoded.data {
                        return completion(.success(response))
                    } else if let errorDetail = decoded.meta.message, !decoded.meta.status.isSuccessStatusCode {
                        return completion(.failure(.detailedAPIError(errorDetail)))
                    }
                    return completion(.failure(.unknown))
                } catch {
                    return completion(.failure(.decodingError(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    private func getData(from urlRequest: URLRequest,
                         completion: @escaping NetworkCompletion<Data>) -> NetworkTask {
        let task = network.dataTask(with: urlRequest) { result in
            switch result {
            case .success(let data):
                if data.isEmpty { return completion(.failure(.noDataError)) }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()

        return task
    }
}
