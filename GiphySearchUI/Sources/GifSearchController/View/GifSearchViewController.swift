import UIKit

protocol GifSearchViewOutput {
    
}

final class GifSearchViewController: UIViewController, StoryboardInstantiable {
    static let identifier = "GifSearchViewController"
    static let storyboardName = "GifSearchViewController"

    var presenter: GifSearchViewOutput?
}

extension GifSearchViewController: GifSearchViewInput {
    
}
