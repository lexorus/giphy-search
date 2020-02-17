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
    func playGif(with data: GifPlayerData) {
        gifPlayerViewController?.playGif(with: data)
    }
}
