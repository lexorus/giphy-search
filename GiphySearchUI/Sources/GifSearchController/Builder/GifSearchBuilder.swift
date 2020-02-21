import Foundation

public final class GifSearchBuilder {
    public static func build(gifResultsFetcher: GifSearchResultsFetcher,
                             gifDataProvider: @escaping GifDataProvider) -> GifSearchViewController {
        let vc = GifSearchViewController.instantiate()
        let presenter = GifSearchPresenter(view: vc,
                                           gifResultsFetcher: gifResultsFetcher,
                                           gifDataProvider: gifDataProvider)
        vc.presenter = presenter

        return vc
    }
}
