import Foundation

public struct GifPlayerData {
    public let gifTitle: String
    public let gifURL: String
    public let gifVideoURL: URL

    public init(gifTitle: String, gifURL: String, gifVideoURL: URL) {
        self.gifTitle = gifTitle
        self.gifURL = gifURL
        self.gifVideoURL = gifVideoURL
    }
}
