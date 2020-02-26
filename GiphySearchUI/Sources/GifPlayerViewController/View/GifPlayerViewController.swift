import UIKit
import AVKit

protocol GifPlayerViewOutput {
    func viewDidLoad()
    func playGif(with data: GifPlayerData)
}

public final class GifPlayerViewController: UIViewController, StoryboardInstantiable {
    static let identifier = "GifPlayerViewController"
    static let storyboardName = "GifPlayerViewController"

    @IBOutlet private weak var gifTitle: UILabel!
    @IBOutlet private weak var gifURL: UILabel!
    @IBOutlet private weak var videoPlayerController: AVPlayerViewController! {
        didSet {
            videoPlayerController.showsPlaybackControls = false
            videoPlayerController.view.backgroundColor = .clear
        }
    }

    var presenter: GifPlayerViewOutput?

    public override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

    func playGif(with data: GifPlayerData) {
        presenter?.playGif(with: data)
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let videoPlayerVC = segue.destination as? AVPlayerViewController {
            self.videoPlayerController = videoPlayerVC
        }
    }
}

extension GifPlayerViewController: GifPlayerViewInput {
    func set(gifTitle: String, gifURL: String, player: Player) {
        onMain {
            self.gifTitle.text = gifTitle
            self.gifURL.text = gifURL
            self.videoPlayerController.player = player as? AVPlayer
        }
    }
}
