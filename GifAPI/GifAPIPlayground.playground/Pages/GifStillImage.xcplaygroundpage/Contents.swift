import Foundation
import UIKit
import PlaygroundSupport
import GifAPI

let giphyAPI: GifAPI = GiphyAPI(apiKey: "your_giphy_api_token")

let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 300, height: 300))
PlaygroundPage.current.liveView = imageView

giphyAPI.getRandomGIF { result in
    switch result {
    case .success(let gif):
        giphyAPI.getStillImageData(for: gif) { result in
            switch result {
            case .success(let data):
                imageView.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    case .failure(let error):
        print(error)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
