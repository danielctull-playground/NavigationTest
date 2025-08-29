import RegexBuilder

public struct Route<Value> {
  private let value: (Link) throws -> Value?
}

extension Route {

  public init<Output>(
    regex: Regex<Output>,
    transform: @escaping (Output) -> Value?
  ) {
    self.value = { link in
      guard let match = try regex.wholeMatch(in: link.string) else { return nil }
      return transform(match.output)
    }
  }

  public init<Output>(
    @RegexComponentBuilder regex: () -> Regex<Output>,
    transform: @escaping (Output) -> Value?
  ) {
    self.init(regex: regex(), transform: transform)
  }

  public func value(for link: Link) throws -> Value? {
    try value(link)
  }
}

extension Route {

  public init(
    domain: Link.Domain,
    value: CharacterClass,
    transform: @escaping (String) -> Value?
  ) {
    self.init {
      "nav://\(domain.value)/"
      Capture {
        OneOrMore(value)
      }
    } transform: { output in
      transform(String(output.1))
    }
  }
}
