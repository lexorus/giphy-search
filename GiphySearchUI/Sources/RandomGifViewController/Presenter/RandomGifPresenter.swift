import Foundation

enum RandomGifViewState {
    case play(GifPlayerData)
    case error(message: String, onRetry: () -> Void)
}

protocol RandomGifViewInput: class {
    func configure(for state: RandomGifViewState)
}

final class RandomGifPresenter {
    private weak var view: RandomGifViewInput?
    private let gifDataProvider: GifDataProvider
    private var gifDataRequestCancellable: Cancellable?
    private let schedulerType: Scheduler.Type
    private var timer: Scheduler?

    init(view: RandomGifViewInput,
         gifDataProvider: @escaping GifDataProvider,
         schedulerType: Scheduler.Type = Timer.self) {
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
        gifDataRequestCancellable?.cancel()
        gifDataRequestCancellable = gifDataProvider { [weak self] result in
            self?.gifDataRequestCancellable = nil
            switch result {
            case .success(let response):
                self?.view?.configure(for: .play(response))
            case .failure(let error):
                let onRetry: () -> Void = { [weak self] in self?.playNewGif() }
                self?.view?.configure(for: .error(message: error,
                                                  onRetry: onRetry))
            }
        }
    }
}

extension RandomGifPresenter: RandomGifViewOutput {
    func viewDidLoad() {
        startPlayingRandomGif()
    }
}
