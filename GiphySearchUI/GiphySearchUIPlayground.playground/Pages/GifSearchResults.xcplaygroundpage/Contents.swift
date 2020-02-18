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

var queryObserver: ((String) -> Void)?
var query: String = "" {
    didSet {
        queryObserver?(query)
    }
}

let fetcher = Fetcher()

let vc = GifSearchResultsBuilder.build(queryProvider: {  queryObserver = $0},
                                       fetcher: fetcher)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    query = "n"
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    query = "na"
}

PlaygroundPage.current.liveView = vc

PlaygroundPage.current.needsIndefiniteExecution = true
