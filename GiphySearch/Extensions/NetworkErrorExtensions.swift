import Foundation
import GifAPI
import GiphySearchUI

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .apiError(let message?, _), .detailedAPIError(let message):
            return "API Error: \(message)"
        case .noDataError:
            return "Empty data received from server."
        case .decodingError:
            return "Failed to decode received data."
        case .failedToBuildURL, .unknown, .apiError:
            return "Failed to connect to the server."
        }
    }
}
