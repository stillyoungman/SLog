import Foundation

/// Unit to log.
public enum Message {
    case regular(String)
    case templated(String, [TypeWrapper])

    public enum Kind {
        case regular, templated
    }
}

public extension Message {
    static func templated(_ string: String, _ arguments: TypeWrapper...) -> Message {
        .templated(string, arguments)
    }
}

extension Message: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .regular(value)
    }
}
