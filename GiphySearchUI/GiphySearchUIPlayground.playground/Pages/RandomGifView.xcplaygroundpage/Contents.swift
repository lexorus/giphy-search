import Foundation
import UIKit
import GiphySearchUI
import PlaygroundSupport

let videoURL = URL(string: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/giphy.mp4?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=giphy.mp4")!
let gifPlayerData = GifPlayerData(gifTitle: "Naruto run", gifURL: "https://gph.is/g/4AQP3vN", gifVideoURL: videoURL)
let gifDataProvider: GifDataProvider = { closure in
    closure(gifPlayerData)
}

let randomGifViewController = RandomGifBuilder.build(gifDataProvider: gifDataProvider)

PlaygroundPage.current.liveView = randomGifViewController

PlaygroundPage.current.needsIndefiniteExecution = true
