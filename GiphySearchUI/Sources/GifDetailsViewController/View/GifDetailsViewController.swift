import UIKit

protocol GifDetailsViewOutput {
    func viewDidLoad()
}

public final class GifDetailsViewController: UIViewController, StoryboardInstantiable {
    static let storyboardName = "GifDetailsViewController"
    static let identifier = "GifDetailsViewController"

    @IBOutlet private weak var gifPlayerContainer: UIView!

    var presenter: GifDetailsViewOutput!

    public override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
}

extension GifDetailsViewController: GifDetailsViewInput {
    func configure(for gifData: GifPlayerData) {
        title = gifData.gifTitle
        setupGifPlayerView(with: gifData)
    }

    private func setupGifPlayerView(with data: GifPlayerData) {
        let gifPlayerViewController = GifPlayerBuilder.build(with: data)
        addChildViewController(gifPlayerViewController, into: gifPlayerContainer)
    }
}