import UIKit

public final class GifPlayerBuilder {
    public static func build(with data: GifPlayerData? = nil) -> GifPlayerViewController {
        let viewController = GifPlayerViewController.instantiate()
        let presenter = GifPlayerPresenter(view: viewController, data: data)
        viewController.presenter = presenter

        return viewController
    }
}
