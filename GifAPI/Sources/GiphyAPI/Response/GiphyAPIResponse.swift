import Foundation

struct GiphyAPIResponse<T: Decodable & Equatable>: Decodable {
    let data: T?
    let meta: Meta

    struct Meta: Decodable {
        let status: Int
        let message: String?

        enum CodingKeys: String, CodingKey {
            case status
            case message = "msg"
        }
    }
}
