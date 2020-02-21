import Foundation
import UIKit

enum GitSearchViewState {
    case empty
    case searchResults
}

protocol GifSearchViewInput: class {
    func configure(for state: GitSearchViewState)
}

final class GifSearchPresenter {
    private weak var view: GifSearchViewInput?
    private let gifDataProvider: GifDataProvider
    private let gifResultsFetcher: GifSearchResultsFetcher

    private var queryObserver: ((String) -> Void)?

    init(view: GifSearchViewInput,
         gifResultsFetcher: GifSearchResultsFetcher,
         gifDataProvider: @escaping GifDataProvider) {
        self.view = view
        self.gifResultsFetcher = gifResultsFetcher
        self.gifDataProvider = gifDataProvider
    }

    var callCount = 0
}

extension GifSearchPresenter: GifSearchViewOutput {
    var randomGifDataProvider: GifDataProvider { gifDataProvider }
    var searchQueryProvider: GifSearchQueryProvider { { [weak self] in self?.queryObserver = $0 } }
    var searchResultsFetcher: GifSearchResultsFetcher { gifResultsFetcher }

    func searchTextDidChange(text: String) {
        queryObserver?(text)
        let state: GitSearchViewState = text.count > 0 ? .searchResults : .empty
        view?.configure(for: state)
    }
}
