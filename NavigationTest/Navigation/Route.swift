import RegexBuilder

public struct Route<Value> {

  private let value: (Link) throws -> Value?

  public init<Output>(regex: Regex<Output>, transform: @escaping (Output) -> Value?) {
    self.value = { link in
      guard let match = try regex.wholeMatch(in: link.string) else { return nil }
      return transform(match.output)
    }
  }

  public init<Output>(@RegexComponentBuilder regex: () -> Regex<Output>, transform: @escaping (Output) -> Value?) {
    self.init(regex: regex(), transform: transform)
  }

  public func value(for link: Link) throws -> Value? {
    try value(link)
  }
}
