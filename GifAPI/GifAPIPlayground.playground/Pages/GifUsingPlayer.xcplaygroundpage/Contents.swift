import Foundation
import AVKit
import AVFoundation
import PlaygroundSupport
import GifAPI

let giphyAPI: GifAPI = GiphyAPI(apiKey: "your_giphy_api_token")

let playerViewController = AVPlayerViewController()
let playerView = AVQueuePlayer()
playerViewController.player = playerView
PlaygroundPage.current.liveView = playerViewController

giphyAPI.getRandomGIF { result in
    switch result {
    case .success(let gif):
        let playerItem = AVPlayerItem(url: URL(string: gif.originalVideoURL)!)
        playerView.insert(playerItem, after: nil)
        playerView.play()
    case .failure(let error):
        print(error)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
