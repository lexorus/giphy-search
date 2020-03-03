import Foundation

public final class GifDetailsBuilder {
    public static func build(gifData: GifPlayerData) -> GifDetailsViewController {
        let viewController = GifDetailsViewController.instantiate()
        let presenter = GifDetailsPresenter(view: viewController, gifData: gifData)
        viewController.presenter = presenter

        return viewController
    }
}
