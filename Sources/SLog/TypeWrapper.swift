import Foundation

/// Makes possible to add type metadata to value.
public enum TypeWrapper {
    case null
    case int(Int)
    case unsignedLong(UInt64)
    case bool(Bool)
    case double(Double)
    case string(String)
    case array([TypeWrapper])
    case dictionary([String: TypeWrapper])
}

public extension TypeWrapper {
    /// Stands for `Integer`
    static func i(_ value: Int?) -> TypeWrapper {
        guard let value = value else { return .null }
        return .int(value)
    }

    /// Stands for `Unsigned Long`
    static func ul(_ value: UInt64?) -> TypeWrapper {
        guard let value = value else { return .null }
        return .unsignedLong(value)
    }

    /// Stands for `Boolean`
    static func b(_ value: Bool?) -> TypeWrapper {
        guard let value = value else { return .null }
        return .bool(value)
    }

    /// Stands for `Double`
    static func d(_ value: Double?) -> TypeWrapper {
        guard let value = value else { return .null }
        return .double(value)
    }

    /// Stands for `String`
    static func s(_ value: String?) -> TypeWrapper {
        guard let value = value else { return .null }
        return .string(value)
    }

    /// Stands for `Array`
    static func a(_ value: [TypeWrapper]?) -> TypeWrapper {
        guard let value = value else { return .null }
        return .array(value)
    }

    /// Stands for `Dictionary`
    static func d(_ value: [String: TypeWrapper]?) -> TypeWrapper {
        guard let value = value else { return .null }
        return .dictionary(value)
    }
}

/// A simple generic `CodingKey`. Used mostly by unkeyed containers to keep
/// track of indexes in a coding path. A shame none of the several copies of
/// exactly this in the standard library are public.
public struct GenericCodingKey: CodingKey {
    public let stringValue: String
    public let intValue: Int?

    public init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }

    public init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
}

extension TypeWrapper: Codable {
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: GenericCodingKey.self) {
            var dict = [String: TypeWrapper]()
            try container.allKeys.forEach { (key) throws in
                dict[key.stringValue] = try container.decode(TypeWrapper.self, forKey: key)
            }
            self = .dictionary(dict)
        } else if var container = try? decoder.unkeyedContainer() {
            var result = [TypeWrapper]()
            while !container.isAtEnd {
                result.append(try container.decode(TypeWrapper.self))
            }
            self = .array(result)
        } else if let container = try? decoder.singleValueContainer() {
            if let integer = try? container.decode(Int.self) {
                self = .int(integer)
            } else if let float = try? container.decode(Double.self) {
                self = .double(float)
            } else if let bool = try? container.decode(Bool.self) {
                self = .bool(bool)
            } else if let string = try? container.decode(String.self) {
                self = .string(string)
            } else {
                self = .null
            }
        } else {
            self = .null
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null: try container.encodeNil()
        case .int(let integer): try container.encode(integer)
        case .unsignedLong(let longUnsigned): try container.encode(longUnsigned)
        case .bool(let bool): try container.encode(bool)
        case .double(let float): try container.encode(float)
        case .string(let string): try container.encode(string)
        case .array(let items): try container.encode(items)
        case .dictionary(let dict): try container.encode(dict)
        }
    }
}

extension TypeWrapper: ExpressibleByNilLiteral {
    public init(nilLiteral _: ()) {
        self = .null
    }
}

extension TypeWrapper: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
}

extension TypeWrapper: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension TypeWrapper: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
}

extension TypeWrapper: ExpressibleByStringLiteral {
    public init(extendedGraphemeClusterLiteral value: String) {
        self = .string(value)
    }

    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension TypeWrapper: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: TypeWrapper...) {
        self = .array(elements)
    }
}

extension TypeWrapper: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, TypeWrapper)...) {
        let dict = [String: TypeWrapper](elements, uniquingKeysWith: { first, _ in first })
        self = .dictionary(dict)
    }
}

extension TypeWrapper: CustomStringConvertible {
    public var description: String {
        guard let data = try? JSONEncoder.init().encode(self),
              let result = String(data: data, encoding: .utf8) else { return "" }

        return result
    }
}

extension TypeWrapper {
    public init(_ value: UInt64) {
        self = .unsignedLong(value)
    }
}
