import Foundation
import CoreMedia
@testable import GiphySearchUI

final class MockPlayer: Player {
    static var instance = MockPlayer()

    var url: URL?

    static func with(url: URL) -> Player {
        instance.url = url

        return instance
    }

    var playCalled = false
    func play() {
        playCalled = true
    }

    var pauseCalled = false
    func pause() {
        pauseCalled = true
    }

    var seekArgs: (CMTime)?
    func seek(to time: CMTime) {
        seekArgs = (time)
    }
}
