import Foundation
@testable import GiphySearchUI

final class MockGifPlayerViewInput: GifPlayerViewInput {
    // swiftlint:disable:next large_tuple
    var setArgs: (gifTitle: String, gifURL: String, player: Player)?
    func set(gifTitle: String, gifURL: String, player: Player) {
        setArgs = (gifTitle, gifURL, player)
    }
}
