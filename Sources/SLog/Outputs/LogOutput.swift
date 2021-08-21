import Foundation

public protocol LogOutput {
    func log(level: Level,
             message: Message,
             source: String?,
             file: String, function: String, line: UInt)

    var logLevel: Level { get }
    var preferredMessageType: Message.Kind { get }
}

extension LogOutput {
    public var logLevel: Level { .trace  }
    public var preferredMessageType: Message.Kind { .regular }
}
