import Foundation
import UIKit

enum GifSearchResultsState {
    enum Stage {
        case initial
    }

    case loading(Stage)
    case loaded(Stage)
    case error(Stage, message: String, onRetry: () -> Void)
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
        fetcher.searchForGifs(with: query, pageSize: 24, offset: 0) { [weak self] result in
            guard let welf = self else { return }
            switch result {
            case .success(let response):
                welf.presentedGifIds = response.map({ $0.id })
                welf.cellModels = welf.generateCellModels(for: response.map({ $0.url }))
                welf.view?.configure(for: .loaded(.initial))
            case .failure(let error):
                let onRetry: () -> Void = { [weak self] in
                    self?.queryDidChange(to: query)
                }
                welf.view?.configure(for: .error(.initial, message: error, onRetry: onRetry))
            }
        }
    }

    private func generateCellModels(for stringURLs: [String]) -> [GifCell.Model] {
        stringURLs.map { stringURL in
            GifCell.Model { [weak self] closure in
                self?.fetcher.data(for: stringURL) { result in
                    switch result {
                    case .success(let response):
                        guard let image = UIImage(data: response) else { return }
                        closure(image)
                    case .failure(let error):
                        debugPrint("Error loading image: \(error)")
                    }
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
