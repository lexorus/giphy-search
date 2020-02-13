import AVFoundation

protocol Player {
    init(url: URL)
    func play()
    func seek(to: CMTime)
}

extension AVPlayer: Player { }
