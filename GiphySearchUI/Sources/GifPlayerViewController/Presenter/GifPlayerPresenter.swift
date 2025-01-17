import Foundation
import AVFoundation

protocol GifPlayerViewInput: class {
    func set(gifTitle: String, gifURL: String, player: Player)
}

final class GifPlayerPresenter {
    private let notifier: Notifier
    private let data: GifPlayerData?
    private let playerType: Player.Type
    private var player: Player?

    private weak var view: GifPlayerViewInput?

    init(view: GifPlayerViewInput,
         data: GifPlayerData? = nil,
         notifier: Notifier = NotificationCenter.default,
         playerType: Player.Type = AVPlayer.self) {
        self.view = view
        self.data = data
        self.playerType = playerType
        self.notifier = notifier
    }

    deinit {
        notifier.removeObserver(self)
    }

    private func play() {
        notifier.removeObserver(self)
        player?.play()
        notifier.addObserver(self,
                            selector: #selector(replay),
                            name: .AVPlayerItemDidPlayToEndTime)
    }

    @objc private func replay() {
        player?.seek(to: .zero)
        player?.play()
    }
}

extension GifPlayerPresenter: GifPlayerViewOutput {
    func viewDidLoad() {
        guard let data = data else { return }
        playGif(with: data)
    }

    func viewWillAppear() {
        self.player?.play()
    }

    func viewWillDisappear() {
        self.player?.pause()
    }

    func playGif(with data: GifPlayerData) {
        let player = playerType.with(url: data.gifVideoURL)
        view?.set(gifTitle: data.gifTitle, gifURL: data.gifURL, player: player)
        self.player = player
        play()
    }
}
