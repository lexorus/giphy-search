import GifAPI
import GiphySearchUI

extension GifPlayerData {
    init?(gif: Gif) {
        guard let gifVideoURL = URL(string: gif.originalVideoURL) else { return nil }
        self.init(gifTitle: gif.title, gifURL: gif.bitlyURL, gifVideoURL: gifVideoURL)
    }
}
