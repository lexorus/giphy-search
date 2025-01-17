import Foundation
import UIKit
import GifAPI
import GiphySearchUI

final class OfflineFakeGifRepository {
    private var sampleGif1: Gif {
        .init(id: "jniKOKepMY8KotuZMx", title: "klever GIF by Alberi Creativos",
              bitlyURL: "https://gph.is/g/4AAz274", rating: "g",
              stillImageURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/100w_s.gif?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=100w_s.gif",
              fixedWidthVideoURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/100w.mp4?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=100w.mp4",
              originalGIFURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/giphy.gif?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=giphy.gif",
              originalVideoURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/giphy.mp4?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=giphy.mp4")
    }

    private var sampleGif2: Gif {
        .init(id: "JRlqKEzTDKci5JPcaL", title: "Naruto run",
              bitlyURL: "https://gph.is/g/4AQP3vN", rating: "g",
              stillImageURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/100w_s.gif?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=100w_s.gif",
              fixedWidthVideoURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/100w.mp4?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=100w.mp4",
              originalGIFURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/giphy.gif?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=giphy.gif",
              originalVideoURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/giphy.mp4?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=giphy.mp4")
    }

    private var gifs: [String: Gif] {
        [sampleGif1.id: sampleGif1,
         sampleGif2.id: sampleGif2]
    }

    private var cachesImages = [String: Data]()

    init() {}
}

extension OfflineFakeGifRepository: GifRepository {
    private var randomGif: Gif! { gifs.values.randomElement() }
    convenience init(gifAPI: GifAPI) { self.init() }
    func getGif(for id: String) -> Gif? { gifs[id] }

    func getRandomGif(completion: @escaping (Result<Gif, FetchingError>) -> Void) -> Cancellable? {
        guard let gif = [sampleGif1, sampleGif2].randomElement() else { return nil }
        completion(.success(gif))
        return nil
    }

    func searchForGifs(with query: String,
                       pageSize: UInt,
                       offset: UInt,
                       completion: @escaping (Result<[(id: String, url: String)], FetchingError>) -> Void)
        -> Cancellable? {
            cachesImages.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let indexedResults = (0..<pageSize).map { _ -> (id: String, url: String) in
                    let randomGif = self.randomGif!
                    return ("\(randomGif.id)", "\(randomGif.stillImageURL)")
                }
                completion(.success(indexedResults))
            }
            return nil
    }

    func data(for stringURL: String, completion: @escaping (Result<Data, FetchingError>) -> Void) -> Cancellable? {
        if let cachedImage = cachesImages[stringURL] {
            completion(.success(cachedImage))
            return nil
        }
        let randomLoadTime = [0.2, 0.4, 0.6, 1.0].randomElement()!
        let sampleImageData = UIImage(systemName: "camera.fill")!.pngData()!
        DispatchQueue.main.asyncAfter(deadline: .now() + randomLoadTime) {
            self.cachesImages[stringURL] = sampleImageData
            completion(.success(sampleImageData))
        }
        return nil
    }
}
