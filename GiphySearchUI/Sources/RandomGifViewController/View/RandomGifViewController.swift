import UIKit

protocol RandomGifViewOutput {
    func viewDidLoad()
}

public final class RandomGifViewController: UIViewController, StoryboardInstantiable {
    static let identifier = "RandomGifViewController"
    static let storyboardName = "RandomGifViewController"

    @IBOutlet private weak var gifPlayerViewContainer: UIView!
    private weak var gifPlayerViewController: GifPlayerViewController?

    var presenter: RandomGifViewOutput?

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupGifPlayerViewController()
        presenter?.viewDidLoad()
    }

    private func setupGifPlayerViewController() {
        let gifPlayerViewController = GifPlayerBuilder.build()
        addChildViewController(gifPlayerViewController, into: gifPlayerViewContainer)
        self.gifPlayerViewController = gifPlayerViewController
    }
}

extension RandomGifViewController: RandomGifViewInput {
    func configure(for state: RandomGifViewState) {
        onMain {
            switch state {
            case .play(let data):
                self.gifPlayerViewController?.playGif(with: data)
            case let .error(message, onRetry):
                self.presentErrorAlert(with: message, onRetry: onRetry)
            }
        }
    }
}
