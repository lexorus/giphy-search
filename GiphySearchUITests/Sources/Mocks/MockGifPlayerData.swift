import Foundation
@testable import GiphySearchUI

extension GifPlayerData {
    static func mocked(gifTitle: String = "gifTitle",
                       gifURL: String = "gifURL",
                       gifVideoURL: URL = URL(string: "google.com")!) -> GifPlayerData {
        return .init(gifTitle: gifTitle, gifURL: gifURL, gifVideoURL: gifVideoURL)
    }
}
