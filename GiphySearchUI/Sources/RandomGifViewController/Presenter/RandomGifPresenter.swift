import Foundation

protocol RandomGifViewInput: class {
    func playGif(with data: GifPlayerData)
}

final class RandomGifPresenter {
    private weak var view: RandomGifViewInput?
    private let gifDataProvider: GifDataProvider

    init(view: RandomGifViewInput, gifDataProvider: @escaping GifDataProvider) {
        self.view = view
        self.gifDataProvider = gifDataProvider
    }
}

extension RandomGifPresenter: RandomGifViewOutput {
    func viewDidLoad() {
        gifDataProvider { [weak self] data in
            self?.view?.playGif(with: data)
        }
    }
}
