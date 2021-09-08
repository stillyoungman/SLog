import Foundation

public protocol LogBackend {
    func log(level: Level,
             message: Message,
             source: String?,
             file: String, function: String, line: UInt)

    var logLevel: Level { get }
    var preferredMessageType: Message.Kind { get }
}

extension LogBackend {
    public var logLevel: Level { .trace  }
    public var preferredMessageType: Message.Kind { .regular }
}
