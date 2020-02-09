import Foundation

public enum NetworkError: Error {
    case failedToBuildURL
    case apiError(message: String?, error: Error?)
    case noDataError
    case detailedAPIError(String)
    case decodingError(Error)
    case unknown
}

public protocol NetworkTask {
    func resume()
    func cancel()
}

protocol Network {
    @discardableResult
    func dataTask(with url: URLRequest,
                  completion: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkTask
}

extension URLSessionTask: NetworkTask {}
extension URLSession: Network {}
