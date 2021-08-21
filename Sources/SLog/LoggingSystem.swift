import Foundation

public class LoggingSystem {
    internal static var factory: () -> LogOutput = { NoOpLogOutput() }
    fileprivate static var initialized = false

    public static func bootstrap(_ factory: @escaping () -> LogOutput) {
        precondition(!self.initialized, "Logging system can only be initialized once per process.")
        self.factory = factory
        self.initialized = true
    }
}
