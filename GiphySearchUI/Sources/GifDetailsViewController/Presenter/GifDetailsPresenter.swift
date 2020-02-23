import Foundation

protocol GifDetailsViewInput: class {
    func configure(for gifData: GifPlayerData)
}

final class GifDetailsPresenter {
    private weak var view: GifDetailsViewInput?
    private let gifData: GifPlayerData

    init(view: GifDetailsViewInput, gifData: GifPlayerData) {
        self.view = view
        self.gifData = gifData
    }
}

extension GifDetailsPresenter: GifDetailsViewOutput {
    func viewDidLoad() {
        view?.configure(for: gifData)
    }
}
