import Foundation
import UIKit

enum GifSearchLoadingState {
    enum Stage {
        case initial
    }

    case loading(Stage)
    case loaded(Stage)
}

protocol GifSearchResultsViewnput: class {
    func configure(for state: GifSearchLoadingState)
}

final class GifSearchResultsPresenter {
    private weak var view: GifSearchResultsViewnput?
    private let fetcher: GifSearchResultsFetcher

    var cellModels = [GifCell.Model]()

    init(view: GifSearchResultsViewnput,
         queryProvider: (@escaping (String) -> Void) -> Void,
         fetcher: GifSearchResultsFetcher) {
        self.view = view
        self.fetcher = fetcher
        queryProvider { [weak self] query in self?.queryDidChange(to: query) }
    }

    private func queryDidChange(to query: String) {
        view?.configure(for: .loading(.initial))
        fetcher.searchForGifs(with: query, pageSize: 24, offset: 0) { [weak self] stringURLs in
            guard let welf = self else { return }
            welf.cellModels = welf.generateCellModels(for: stringURLs)
            welf.view?.configure(for: .loaded(.initial))
        }
    }

    private func generateCellModels(for stringURLs: [String]) -> [GifCell.Model] {
        stringURLs.map { stringURL in
            GifCell.Model { [weak self] closure in
                self?.fetcher.data(for: stringURL) { data in
                    guard let image = UIImage(data: data) else { return }
                    closure(image)
                }
            }
        }
    }
}

extension GifSearchResultsPresenter: GifSearchResultsViewOutput {

}
