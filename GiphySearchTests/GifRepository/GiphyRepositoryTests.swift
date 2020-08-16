import XCTest
import GifAPI
import GiphySearchUI
@testable import GiphySearch

final class GiphyRepositoryTests: XCTestCase {
    var repository: GiphyRepository!
    var mockGifAPI: MockGifAPI!

    override func setUp() {
        super.setUp()

        mockGifAPI = MockGifAPI(apiKey: "")
        repository = GiphyRepository(gifAPI: mockGifAPI)
    }

    override func tearDown() {
        repository = nil
        mockGifAPI = nil

        super.tearDown()
    }

    // MARK: - getRandomGif

    func test_getRandomGif_whenSucceeded_thenShouldCallCompletionWithGif() {
        // GIVEN
        let sampleGif = Gif.mocked()

        // WHEN
        var result: Result<Gif, FetchingError>?
        let completion: (Result<Gif, FetchingError>) -> Void = { result = $0 }
        _ = repository.getRandomGif(completion: completion)
        mockGifAPI.getRandomGIFFuncCheck.arguments?(.success(sampleGif))

        // THEN
        XCTAssertEqual(result, .success(sampleGif))
    }

    func test_getRandomGif_whenFailed_thenShouldCallCompletionErrorsDescription() {
        // GIVEN
        let sampleError = NetworkError.noDataError

        // WHEN
        var result: Result<Gif, FetchingError>?
        let completion: (Result<Gif, FetchingError>) -> Void = { result = $0 }
        _ = repository.getRandomGif(completion: completion)
        mockGifAPI.getRandomGIFFuncCheck.arguments?(.failure(sampleError))

        // THEN
        XCTAssertEqual(result, .failure(sampleError.description))
    }
}
