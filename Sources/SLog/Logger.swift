import Foundation

public class Logger: ILogger {
    public let output: LogOutput
    public let source: String?

    public init(source: String? = nil) {
        self.output = LoggingSystem.factory()
        self.source = source
    }

    @inlinable
    open func log(level: Level,
             message: Message,
             file: String = #file, function: String = #function, line: UInt = #line) {
        if output.logLevel <= level {
            output.log(level: level, message: message, source: source,
                       file: file, function: function, line: line)
        }
    }
}
