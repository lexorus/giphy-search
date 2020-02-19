import UIKit

protocol GifSearchViewOutput {
    var randomGifDataProvider: GifDataProvider { get }
}

public final class GifSearchViewController: UIViewController, StoryboardInstantiable {
    static let identifier = "GifSearchViewController"
    static let storyboardName = "GifSearchViewController"

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private weak var randomGifViewController: RandomGifViewController?

    var presenter: GifSearchViewOutput!

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupRandomGifViewController()
    }

    private func setupRandomGifViewController() {
        let randomGifViewController = RandomGifBuilder.build(gifDataProvider: presenter.randomGifDataProvider)
        addChildViewController(randomGifViewController, into: containerView)
        self.randomGifViewController = randomGifViewController
    }
}

extension GifSearchViewController: GifSearchViewInput {
    
}
