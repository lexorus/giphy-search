import UIKit
import GifAPI
import GiphySearchUI

final class GifSearchFlow {
    private let navigationController = UINavigationController()
    private let gifRepository: GifRepository

    init(gifRepository: GifRepository = OfflineFakeGifRepository()) {
//        GiphyRepository(gifAPI: GiphyAPI(apiKey: "your_giphy_api_token"))) {
        self.gifRepository = gifRepository
    }

    func start() -> UIViewController {
        let onGifSelection: (String) -> Void = { [weak self] in
            guard let detailedGifVC = self?.buildGifDetailsViewControllerForGif(with: $0) else { return }
            self?.navigationController.pushViewController(detailedGifVC, animated: true)
        }
        let searchVC = buildSearchViewController(completion: onGifSelection)
        navigationController.viewControllers = [searchVC]

        return navigationController
    }

    private func buildSearchViewController(completion: @escaping (String) -> Void) -> GifSearchViewController {
        let fetcher: GifSearchResultsFetcher = gifRepository
        let gifDataProvider: GifDataProvider = { [weak self] completion in
            self?.gifRepository.getRandomGif { result in
                switch result {
                case .success(let gif):
                    guard let gifVideoURL = URL(string: gif.originalVideoURL) else {
                        return completion(.failure("Invalid video URL"))
                    }
                    completion(.success(.init(gifTitle: gif.title, gifURL: gif.bitlyURL, gifVideoURL: gifVideoURL)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

        return GifSearchBuilder.build(gifResultsFetcher: fetcher,
                                      gifDataProvider: gifDataProvider,
                                      onGifSelected: completion)
    }

    private func buildGifDetailsViewControllerForGif(with id: String) -> GifDetailsViewController? {
        guard let gif = gifRepository.getGif(for: id),
            let gifPlayerData = GifPlayerData(gif: gif) else { return nil }
        return GifDetailsBuilder.build(gifData: gifPlayerData)
    }
}
