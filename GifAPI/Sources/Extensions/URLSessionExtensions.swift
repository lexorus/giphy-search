import Foundation

extension URLSession {
    @discardableResult
    func dataTask(with url: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkTask {
        return dataTask(with: url) { (data, response, error) in
            if (error as NSError?)?.code == NSURLErrorCancelled { return }
            if let response = response as? HTTPURLResponse,
                !response.statusCode.isSuccessStatusCode {
                let message = data.flatMap { String(data: $0, encoding: .utf8) }
                return completion(.failure(.apiError(message: message, error: error)))
            }
            guard let data = data else { return completion(.failure(.noDataError)) }
            completion(.success(data))
        }
    }
}
