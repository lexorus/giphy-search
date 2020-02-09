import Foundation

extension Int {
    var isSuccessStatusCode: Bool {
        (200..<300) ~= self
    }
}
