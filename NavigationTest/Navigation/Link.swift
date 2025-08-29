
public struct Link: Hashable, Sendable, Identifiable {
  let string: String
  public var id: String { string }

  public init(_ string: String) {
    self.string = string
  }
}

extension Link {

  public static func navigation(domain: String, value: String) -> Link {
    Link("nav://\(domain)/\(value)")
  }
}
