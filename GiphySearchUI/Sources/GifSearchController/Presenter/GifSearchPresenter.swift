import Foundation

protocol GifSearchViewInput: class {
    
}

final class GifSearchPresenter {
    private weak var view: GifSearchViewInput?

    init(view: GifSearchViewInput) {
        self.view = view
    }
}

extension GifSearchPresenter: GifSearchViewOutput {

}
