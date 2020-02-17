import UIKit

public struct GifPlayerData {
    public let gifTitle: String
    public let gifURL: String
    public let gifVideoURL: URL

    public init(gifTitle: String, gifURL: String, gifVideoURL: URL) {
        self.gifTitle = gifTitle
        self.gifURL = gifURL
        self.gifVideoURL = gifVideoURL
    }
}

public final class GifPlayerBuilder {
    public static func build(with data: GifPlayerData? = nil) -> GifPlayerViewController {
        let vc = GifPlayerViewController.instantiate()
        let presenter = GifPlayerPresenter(view: vc, data: data)
        vc.presenter = presenter

        return vc
    }
}
