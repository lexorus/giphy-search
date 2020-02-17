import Foundation

protocol RandomGifViewInput: class {
    func playGif(with data: GifPlayerData)
}

final class RandomGifPresenter {
    private weak var view: RandomGifViewInput?
    private let gifDataProvider: GifDataProvider
    private let schedulerType: Scheduler.Type
    private var timer: Scheduler?

    init(view: RandomGifViewInput, gifDataProvider: @escaping GifDataProvider, schedulerType: Scheduler.Type = Timer.self) {
        self.view = view
        self.gifDataProvider = gifDataProvider
        self.schedulerType = schedulerType
    }

    deinit {
        timer?.invalidate()
    }

    private func startPlayingRandomGif() {
        timer = schedulerType.with(timeInterval: 10, shouldRepeat: true, action: { [weak self] _ in
            self?.playNewGif()
        })
        timer?.fire()
    }

    private func playNewGif() {
        gifDataProvider { [weak self] data in
            self?.view?.playGif(with: data)
        }
    }
}

extension RandomGifPresenter: RandomGifViewOutput {
    func viewDidLoad() {
        startPlayingRandomGif()
    }
}
