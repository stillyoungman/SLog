import Foundation

public protocol TemplatedMessageConverter {
    func convertToString(templated: String, arguments: [TypeWrapper]) -> String
}
