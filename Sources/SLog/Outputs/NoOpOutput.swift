import Foundation

class NoOpLogOutput: LogOutput {
    func log(level: Level, message: Message, source: String?,
             file: String, function: String, line: UInt) { }

    var logLevel: Level = .critical
}
