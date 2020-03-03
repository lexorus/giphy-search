import GifAPI

extension Gif {
    static func mocked(id: String = "id", title: String = "title", bitlyURL: String = "bitlyURL.com",
                       rating: String = "g", stillImageURL: String = "stillImageURL.com",
                       fixedWidthVideoURL: String = "fixedWidthVideoURL.com",
                       originalGIFURL: String = "originalGIFURL.com",
                       originalVideoURL: String = "originalVideoURL.com") -> Gif {
        return Gif(id: id, title: title, bitlyURL: bitlyURL, rating: rating, stillImageURL: stillImageURL,
                   fixedWidthVideoURL: fixedWidthVideoURL, originalGIFURL: originalGIFURL,
                   originalVideoURL: originalVideoURL)
    }
}
