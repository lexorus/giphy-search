import Foundation
import AVFoundation

protocol GifPlayerViewInput: class {
    func set(gifTitle: String, gifURL: String, player: Player)
}

final class GifPlayerPresenter {
    private let notifier: Notifier
    private let data: GifPlayerData
    private let player: Player

    private weak var view: GifPlayerViewInput?

    init(view: GifPlayerViewInput,
         data: GifPlayerData,
         notifier: Notifier = NotificationCenter.default,
         playerType: Player.Type = AVPlayer.self) {
        self.view = view
        self.data = data
        self.player = playerType.init(url: data.gifVideoURL)
        self.notifier = notifier
    }

    deinit {
        notifier.removeObserver(self)
    }

    private func play() {
        player.play()
        notifier.addObserver(self,
                            selector: #selector(replay),
                            name: .AVPlayerItemDidPlayToEndTime)
    }

    @objc private func replay() {
        player.seek(to: .zero)
        player.play()
    }
}

extension GifPlayerPresenter: GifPlayerViewOutput {
    func viewDidLoad() {
        view?.set(gifTitle: data.gifTitle, gifURL: data.gifURL, player: player)
        play()
    }
}
