import Foundation

protocol GifSearchViewInput: class {
    
}

final class GifSearchPresenter {
    private weak var view: GifSearchViewInput?
    private let gifDataProvider: GifDataProvider

    init(view: GifSearchViewInput, gifDataProvider: @escaping GifDataProvider) {
        self.view = view
        self.gifDataProvider = gifDataProvider
    }

    var callCount = 0
}

extension GifSearchPresenter: GifSearchViewOutput {
    var randomGifDataProvider: GifDataProvider { gifDataProvider }
}
