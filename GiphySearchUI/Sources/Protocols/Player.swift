import AVFoundation

protocol Player {
    static func with(url: URL) -> Player
    func play()
    func pause()
    func seek(to: CMTime)
}

extension AVPlayer: Player {
    static func with(url: URL) -> Player {
        return self.init(url: url)
    }
}
