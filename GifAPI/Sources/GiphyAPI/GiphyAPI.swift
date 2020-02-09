import Foundation

final public class GiphyAPI {
    private let network: Network
    private let requestFactory: GiphyRequestFactory

    public convenience init(apiKey: String) {
        self.init(apikey: apiKey, network: URLSession.shared)
    }

    init(apikey: String, network: Network) {
        self.requestFactory = GiphyRequestFactory(apiKey: apikey)
        self.network = network
    }

    @discardableResult
    public func getRandomGIF(completion: @escaping (Result<Gif, NetworkError>) -> Void) -> NetworkTask? {
        guard let urlRequest = requestFactory.randomGIFURLRequest() else {
            completion(.failure(.failedToBuildURL))
            return nil
        }
        return get(from: urlRequest, completion: completion)
    }

    @discardableResult
    public func getStillImageData(for gif: Gif,
                                  completion: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkTask? {
        guard let url = URL(string: gif.stillImageURL) else {
            completion(.failure(.failedToBuildURL))
            return nil
        }
        let urlRequest = URLRequest(url: url)

        return getData(from: urlRequest, completion: completion)
    }

    @discardableResult
    private func get<T: Decodable & Equatable>(from urlRequest: URLRequest,
                                               completion: @escaping (Result<T, NetworkError>) -> Void) -> NetworkTask {
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
                         completion: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkTask {
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
