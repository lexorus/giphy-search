import Foundation
import UIKit

enum GifSearchResultsState {
    enum Stage {
        case initial
    }

    case loading(Stage)
    case loaded(Stage)
}

protocol GifSearchResultsViewInput: class {
    func configure(for state: GifSearchResultsState)
}

final class GifSearchResultsPresenter {
    private weak var view: GifSearchResultsViewInput?
    private let fetcher: GifSearchResultsFetcher
    private let onGifSelected: (String) -> Void

    var presentedGifIds = [String]()
    var cellModels = [GifCell.Model]()

    init(view: GifSearchResultsViewInput,
         queryProvider: (@escaping (String) -> Void) -> Void,
         fetcher: GifSearchResultsFetcher,
         onGifSelected: @escaping (String) -> Void) {
        self.view = view
        self.fetcher = fetcher
        self.onGifSelected = onGifSelected
        queryProvider { [weak self] query in self?.queryDidChange(to: query) }
    }

    private func queryDidChange(to query: String) {
        view?.configure(for: .loading(.initial))
        fetcher.searchForGifs(with: query, pageSize: 24, offset: 0) { [weak self] response in
            guard let welf = self else { return }
            welf.presentedGifIds = response.map({ $0.id })
            welf.cellModels = welf.generateCellModels(for: response.map({ $0.url }))
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
    func didSelectItem(at indexPath: IndexPath) {
        onGifSelected(presentedGifIds[indexPath.row])
    }
}
