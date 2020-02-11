import Foundation
import UIKit
import GifAPI
import PlaygroundSupport

let giphyAPI: GifAPI = GiphyAPI(apiKey: "your_giphy_api_token")

giphyAPI.getRandomGIF { result in
    switch result {
    case .success(let gif):
        giphyAPI.getStillImageData(for: gif) { result in
            switch result {
            case .success(let data):
                UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    case .failure(let error):
        print(error)
    }
}

giphyAPI.searchForGifs(with: "naruto", pageSize: 10, offset: 0) { result in
    switch result {
    case .success(let gifs):
        print(gifs)
    case .failure(let error):
        print(error)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
