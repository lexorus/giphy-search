import GifAPI

final class MockGifAPI: GifAPI {
    var apiKey: String?
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    var getRandomGIFStub: NetworkTask = MockNetworkTask()
    var getRandomGIFFuncCheck = FuncCheck<NetworkCompletion<Gif>>()
    func getRandomGIF(completion: @escaping NetworkCompletion<Gif>) -> NetworkTask? {
        getRandomGIFFuncCheck.call(completion)
        return getRandomGIFStub
    }

    var getStillImageDataStub: NetworkTask = MockNetworkTask()
    var getStillImageDataFuncCheck = FuncCheck<(Gif, NetworkCompletion<Data>)>()
    func getStillImageData(for gif: Gif, completion: @escaping NetworkCompletion<Data>) -> NetworkTask? {
        getStillImageDataFuncCheck.call((gif, completion))
        return getStillImageDataStub
    }

    var searchForGifsStub: NetworkTask = MockNetworkTask()
    var searchForGifsFuncCheck = FuncCheck<(String, UInt, UInt, NetworkCompletion<[Gif]>)>()
    func searchForGifs(with query: String, pageSize: UInt,
                       offset: UInt, completion: @escaping NetworkCompletion<[Gif]>) -> NetworkTask? {
        searchForGifsFuncCheck.call((query, pageSize, offset, completion))
        return searchForGifsStub
    }

    var getDataStub: NetworkTask = MockNetworkTask()
    var getDataFuncCheck = FuncCheck<(String, NetworkCompletion<Data>)>()
    func getData(for stringURL: String, completion: @escaping NetworkCompletion<Data>) -> NetworkTask? {
        getDataFuncCheck.call((stringURL, completion))
        return getDataStub
    }
}
