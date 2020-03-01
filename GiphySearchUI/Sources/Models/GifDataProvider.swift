import Foundation

public typealias GifDataProvider = ( @escaping (Result<GifPlayerData, FetchingError>) -> Void) -> Void
