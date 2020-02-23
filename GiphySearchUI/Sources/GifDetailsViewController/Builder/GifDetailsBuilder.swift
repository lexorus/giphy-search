import Foundation

public final class GifDetailsBuilder {
    public static func build(gifData: GifPlayerData) -> GifDetailsViewController {
        let vc = GifDetailsViewController.instantiate()
        let presenter = GifDetailsPresenter(view: vc, gifData: gifData)
        vc.presenter = presenter

        return vc
    }
}
