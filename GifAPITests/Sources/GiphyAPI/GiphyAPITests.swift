import XCTest
@testable import GifAPI

final class GiphyAPITests: XCTestCase {
    var giphyAPI: GiphyAPI!
    var mockNetwork: MockNetwork!
    let apiKey = "apiKey"

    override func setUp() {
        super.setUp()

        mockNetwork = MockNetwork()
        giphyAPI = GiphyAPI(apiKey: apiKey, network: mockNetwork)
    }

    override func tearDown() {
        giphyAPI = nil
        mockNetwork = nil

        super.tearDown()
    }

    func test_getRandomGIF_whenRequestSucceeds_thenShouldDecodeObject() {
        // GIVEN
        let responseData = Data(testBundleFileName: "RandomGifResponse")!

        // WHEN
        var result: Result<Gif, NetworkError>!
        giphyAPI.getRandomGIF { result = $0 }
        mockNetwork.dataTaskCompletion?(.success(responseData))

        // THEN
        let expectedGif = Gif(id: "jniKOKepMY8KotuZMx", title: "klever GIF by Alberi Creativos",
                              bitlyURL: "https://gph.is/g/4AAz274", rating: "g", stillImageURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/200w_s.gif?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=200w_s.gif", fixedWidthVideoURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/200w.mp4?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=200w.mp4", originalGIFURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/giphy.gif?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=giphy.gif", originalVideoURL: "https://media3.giphy.com/media/jniKOKepMY8KotuZMx/giphy.mp4?cid=e1bb72fff7b18f5e32767bc1ff5146fa45f14898a1b59ffc&rid=giphy.mp4")
        XCTAssertEqual(try? result.get(), expectedGif)
    }

    func test_searchForGIF_whenRequestSucceeds_thenShouldDecodeObject() {
        // GIVEN
        let responseData = Data(testBundleFileName: "SearchGifResponse")!

        // WHEN
        var result: Result<[Gif], NetworkError>!
        giphyAPI.searchForGifs(with: "", pageSize: 1, offset: 0) { result = $0 }
        mockNetwork.dataTaskCompletion?(.success(responseData))

        // THEN
        let expectedGif = Gif(id: "JRlqKEzTDKci5JPcaL", title: "",
                              bitlyURL: "https://gph.is/g/4AQP3vN", rating: "g", stillImageURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/200w_s.gif?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=200w_s.gif", fixedWidthVideoURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/200w.mp4?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=200w.mp4", originalGIFURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/giphy.gif?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=giphy.gif", originalVideoURL: "https://media3.giphy.com/media/JRlqKEzTDKci5JPcaL/giphy.mp4?cid=e1bb72ffc913ff0cacf52046c2dbe311f3bf986661a800db&rid=giphy.mp4")
        XCTAssertEqual(try? result.get(), [expectedGif])
    }
}
