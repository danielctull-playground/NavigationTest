
public struct Link: Hashable, Sendable, Identifiable {
  let string: String
  public var id: String { string }

  public init(_ string: String) {
    self.string = string
  }
}

extension Link {

  public static func navigation<Value: CustomStringConvertible>(
    domain: Domain,
    value: Value
  ) -> Link {
    Link("nav://\(domain.value)/\(value)")
  }
}

// MARK: - Link.Domain

extension Link {

  public struct Domain {
    let value: String
  }
}

extension Link.Domain: ExpressibleByStringLiteral {
  public init(stringLiteral value: StaticString) {
    self.init(value: value.withUTF8Buffer {
      String(decoding: $0, as: UTF8.self)
    })
  }
}
