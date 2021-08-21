import Foundation

public class MultiplexLogOutput: LogOutput {
    public let outputs: [LogOutput]
    public let logLevel: Level

    public init(_ outputs: [LogOutput]) { 
        assert(!outputs.isEmpty, "MultiplexLogHandler.outputs MUST NOT be empty")
        self.outputs = outputs
        self.logLevel = outputs.map { $0.logLevel }.min() ?? .trace
    }

    @inlinable
    public func log(level: Level, message: Message, source: String?,
             file: String, function: String, line: UInt) {
        for output in self.outputs where output.logLevel <= level {
            output.log(level: level, message: message, source: source,
                       file: file, function: function, line: line)
       }
    }
}
