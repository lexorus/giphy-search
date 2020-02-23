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

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showNavigationBar()
    }

    private func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
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
