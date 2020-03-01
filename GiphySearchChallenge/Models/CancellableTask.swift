import Foundation
import GifAPI
import GiphySearchUI

final class CancellableTask: GiphySearchUI.Cancellable {
    private let networkTask: NetworkTask

    init(networkTask: NetworkTask) {
        self.networkTask = networkTask
    }

    func cancel() {
        networkTask.cancel()
    }
}

extension NetworkTask {
    func toCancellableTask() -> Cancellable {
        return CancellableTask(networkTask: self)
    }
}
