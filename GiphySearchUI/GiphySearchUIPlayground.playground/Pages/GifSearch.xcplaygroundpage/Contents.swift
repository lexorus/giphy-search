import Foundation
import UIKit
import GiphySearchUI
import PlaygroundSupport

final class Fetcher: GifSearchResultsFetcher {
    init() {}

    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping ([String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(Array.init(repeating: "", count: Int(pageSize)))
        }
    }

    func data(for stringURL: String, completion: @escaping (Data) -> Void) {
        let randomLoadTime = [0.2, 0.4, 0.6, 1.0].randomElement()!
        let sampleImageData = UIImage(systemName: "camera.fill")!.pngData()!
        DispatchQueue.main.asyncAfter(deadline: .now() + randomLoadTime) {
            completion(sampleImageData)
        }
    }
}

let videoURL1 = URL(string: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/giphy.mp4?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=giphy.mp4")!
let gifPlayerData1 = GifPlayerData(gifTitle: "Naruto run", gifURL: "https://gph.is/g/4AQP3vN", gifVideoURL: videoURL1)

let videoURL2 = URL(string: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/giphy.mp4?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=giphy.mp4")!
let gifPlayerData2 = GifPlayerData(gifTitle: "Another GIF", gifURL: "https://gph.is/g/4AAz274", gifVideoURL: videoURL2)

var callCount = 0
let gifDataProvider: GifDataProvider = { closure in
    let data = callCount % 2 == 0 ?
        gifPlayerData1 :
        gifPlayerData2
    closure(data)
    callCount += 1
}

let vc = GifSearchBuilder.build(gifResultsFetcher: Fetcher(), gifDataProvider: gifDataProvider)


PlaygroundPage.current.liveView = vc

PlaygroundPage.current.needsIndefiniteExecution = true
