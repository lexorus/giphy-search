import UIKit

public final class GifPlayerBuilder {
    public static func build(with data: GifPlayerData? = nil) -> GifPlayerViewController {
        let vc = GifPlayerViewController.instantiate()
        let presenter = GifPlayerPresenter(view: vc, data: data)
        vc.presenter = presenter

        return vc
    }
}
