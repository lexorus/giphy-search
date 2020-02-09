import Foundation

extension URL {
    func appendingQueryParameters(_ parametersDictionary: [String: String]) -> URL {
        let urlString = "\(absoluteString)?\(parametersDictionary.queryParameters)"
        return URL(string: urlString) ?? self
    }
}
