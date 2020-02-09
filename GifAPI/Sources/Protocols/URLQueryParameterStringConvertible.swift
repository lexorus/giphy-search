import Foundation

protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}

extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var keyValueQueryElements = [String]()
        forEach { (key, value) in
            if let queryAllowedKey = String(describing: key).addingQueryAllowedPercentEncodind(),
                let queryAllowedValue = String(describing: value).addingQueryAllowedPercentEncodind() {
                keyValueQueryElements.append("\(queryAllowedKey)=\(queryAllowedValue)")
            }
        }

        return keyValueQueryElements.joined(separator: "&")
    }
}
