import Foundation
@testable import GifAPI

final class MockNetwork: Network {
    init() {}

    var dataTaskURL: URLRequest?
    var dataTaskCompletion: ((Result<Data, NetworkError>) -> Void)?
    var dataTaskStub: NetworkTask = MockNetworkTask()
    @discardableResult
    func dataTask(with url: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkTask {
        dataTaskURL = url
        dataTaskCompletion = completion

        return dataTaskStub
    }
}
