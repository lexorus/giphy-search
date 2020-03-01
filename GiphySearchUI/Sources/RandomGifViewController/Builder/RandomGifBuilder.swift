import Foundation

public final class RandomGifBuilder {
    public static func build(gifDataProvider: @escaping GifDataProvider) -> RandomGifViewController {
        let vc = RandomGifViewController.instantiate()
        let presenter = RandomGifPresenter(view: vc, gifDataProvider: gifDataProvider)
        vc.presenter = presenter

        return vc
    }
}
