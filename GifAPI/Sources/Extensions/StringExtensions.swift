import Foundation

extension String {
    func addingQueryAllowedPercentEncodind() -> String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
