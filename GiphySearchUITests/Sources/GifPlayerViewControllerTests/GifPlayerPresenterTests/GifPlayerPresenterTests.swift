import XCTest
@testable import GiphySearchUI

final class GifPlayerPresenterTests: XCTestCase {
    var presenter: GifPlayerPresenter!
    var mockView: MockGifPlayerViewInput!
    var mockNotifier: MockNotifier!
    var mockPlayerType: MockPlayer.Type!
    var sampleData: GifPlayerData = .mocked()

    override func setUp() {
        super.setUp()

        mockView = MockGifPlayerViewInput()
        mockNotifier = MockNotifier()
        mockPlayerType = MockPlayer.self
        presenter = GifPlayerPresenter(view: mockView,
                                       data: sampleData,
                                       notifier: mockNotifier,
                                       playerType: mockPlayerType)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockNotifier = nil
        mockPlayerType = nil

        super.tearDown()
    }

    func setupPresenterWithSampleData() {
        presenter = GifPlayerPresenter(view: mockView,
                                       data: sampleData,
                                       notifier: mockNotifier,
                                       playerType: mockPlayerType)
    }

    func setupPresenterWithNoData() {
        presenter = GifPlayerPresenter(view: mockView,
                                       data: nil,
                                       notifier: mockNotifier,
                                       playerType: mockPlayerType)
    }

    // MARK: viewDidLoad

    func test_viewDidLoad_whenWasInitializedWitNoData_thenShouldNotStartPlaying() {
        // GIVEN
        setupPresenterWithNoData()

        // WHEN
        presenter.viewDidLoad()

        // THEN
        XCTAssertNil(mockView.setArgs)
    }

    func test_viewDidLoad_whenWasInitializedWithData_thenShouldUpdateView() {
        // GIVEN
        setupPresenterWithSampleData()

        // WHEN
        presenter.viewDidLoad()

        // THEN
        XCTAssertEqual(mockView.setArgs?.gifTitle, sampleData.gifTitle)
        XCTAssertEqual(mockView.setArgs?.gifURL, sampleData.gifURL)
        XCTAssertTrue(mockView.setArgs!.player as? MockPlayer === mockPlayerType.instance)
    }

    // MARK: playGif(with:)

    func test_playGif_whenPlay_thenShouldStartObservingPlayerEndPlaying() {
        // GIVEN
        setupPresenterWithSampleData()

        // WHEN
        presenter.playGif(with: sampleData)

        // THEN
        XCTAssertTrue(mockNotifier.addObserverArgs?.observer as? GifPlayerPresenter === presenter)
    }
}
