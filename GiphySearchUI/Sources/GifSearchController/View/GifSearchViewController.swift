import UIKit

protocol GifSearchViewOutput {
    
}

public final class GifSearchViewController: UIViewController, StoryboardInstantiable {
    static let identifier = "GifSearchViewController"
    static let storyboardName = "GifSearchViewController"

    var presenter: GifSearchViewOutput?
}

extension GifSearchViewController: GifSearchViewInput {
    
}
