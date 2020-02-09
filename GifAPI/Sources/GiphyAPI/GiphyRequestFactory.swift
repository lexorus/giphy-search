import Foundation

final class GiphyRequestFactory {
    private let apiKey: String
    private let baseURL = "https://api.giphy.com/v1/gifs"
    private var sharedParams: [String: String] { ["api_key": apiKey] }

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func randomGIFURLRequest() -> URLRequest? {
        let path = "/random"
        guard var url = url(for: path) else { return nil }
        url = url.appendingQueryParameters(sharedParams)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        return urlRequest
    }

    func getGIFURLRequest(for id: String) -> URLRequest? {
        let path = "/\(id)"
        guard var url = url(for: path) else { return nil }
        url = url.appendingQueryParameters(sharedParams)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        return urlRequest
    }

    private func url(for path: String) -> URL? {
        return URL(string: baseURL + path)
    }
}
