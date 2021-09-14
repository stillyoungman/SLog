# SLog

Base SLog project.
SLog is a module-based logging system for Swift applications that allows writing both to Apple's OSLog and to other 
channels (e.g. file) without losing performance.

## Getting started

### Default setup flow.
Run following lines of code to configure logging system (it's better to configure logging as early as possible).
```swift
// Init and configure backends.
let fileBackend = ... 
let anotherBackend = ...
let backend = MultiplexLogBackend([fileBackend, anotherBackend])

// Provide backend factory method.
LoggingSystem.bootstrap { backend }
```

### Usage
```swift
class Component { 
    let logger = Logger(source: "Component")
    
    func doAction() { 
        logger.debug("doAction() is going to be performed.")
        ...
        logger.info("doAction() is going to be finished.")
    }
}
```

Log templated message:
```swift
// let's assume that `err` variable defined in context
logger.error("Error happend in method doAction(). Description: %@", .s(err.localizedDescription))
```

Templated messages give ability to provide more detailed context to LogBackend.
To use values in templated messages you should use TypeWrapper constructors:
```swift
.i(4) // integer
.ul(1000000000000000000) // unsigned long
.b(true) // boolean
.d(3.14) // double
.s("Hello") // string
.a(.s("Hello"), "world", 4, true) // array
.d(["key":.i(4)]) // dictionary
```

The method `logger.debug("Message")` is shorthand for `logger.log(level: .debug, message: "Message")` 
(for other levels same logic).
