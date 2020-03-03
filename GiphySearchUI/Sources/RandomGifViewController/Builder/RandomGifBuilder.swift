import Foundation

public final class RandomGifBuilder {
    public static func build(gifDataProvider: @escaping GifDataProvider) -> RandomGifViewController {
        let viewController = RandomGifViewController.instantiate()
        let presenter = RandomGifPresenter(view: viewController, gifDataProvider: gifDataProvider)
        viewController.presenter = presenter

        return viewController
    }
}
