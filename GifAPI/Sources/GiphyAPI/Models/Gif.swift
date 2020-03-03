import Foundation

public struct Gif: Decodable & Equatable {
    public let id: String
    public let title: String
    public let bitlyURL: String
    public let rating: String
    public let stillImageURL: String
    public let fixedWidthVideoURL: String
    public let originalGIFURL: String
    public let originalVideoURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case bitlyURL = "bitly_url"
        case rating
        case images
    }

    enum ImagesCodingKeys: String, CodingKey {
        case fixedWidth = "fixed_width"
        case fixedWidthStill = "fixed_width_still"
        case original
        case url
        case mp4
    }

    public init(id: String, title: String, bitlyURL: String,
                rating: String, stillImageURL: String,
                fixedWidthVideoURL: String, originalGIFURL: String,
                originalVideoURL: String) {
        self.id = id
        self.title = title
        self.bitlyURL = bitlyURL
        self.rating = rating
        self.stillImageURL = stillImageURL
        self.fixedWidthVideoURL = fixedWidthVideoURL
        self.originalGIFURL = originalGIFURL
        self.originalVideoURL = originalVideoURL
    }
}

public extension Gif {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        bitlyURL = try container.decode(String.self, forKey: .bitlyURL)
        rating = try container.decode(String.self, forKey: .rating)
        let imagesContainer = try container.nestedContainer(keyedBy: ImagesCodingKeys.self, forKey: .images)
        let fixedWidthStillImage = try imagesContainer.nestedContainer(keyedBy: ImagesCodingKeys.self,
                                                                       forKey: .fixedWidthStill)
        stillImageURL = try fixedWidthStillImage.decode(String.self, forKey: .url)
        let fixedWidthImage = try imagesContainer.nestedContainer(keyedBy: ImagesCodingKeys.self, forKey: .fixedWidth)
        fixedWidthVideoURL = try fixedWidthImage.decode(String.self, forKey: .mp4)
        let originalImage = try imagesContainer.nestedContainer(keyedBy: ImagesCodingKeys.self, forKey: .original)
        originalGIFURL = try originalImage.decode(String.self, forKey: .url)
        originalVideoURL = try originalImage.decode(String.self, forKey: .mp4)
    }
}
