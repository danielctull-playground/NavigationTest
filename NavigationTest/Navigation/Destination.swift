import SwiftUI

public struct Destination {
  private let content: (Link) throws -> AnyView?
}

extension Destination {

  public init<Value, Content: View>(
    route: Route<Value>,
    @ViewBuilder content: @escaping (Value) -> Content
  ) {
    self.init { link in
      guard let value = try route.value(for: link) else { return nil }
      return AnyView(content(value))
    }
  }

  public func content(for link: Link) throws -> AnyView? {
    try content(link)
  }
}

extension Destination {

  public init(@Destination.Builder build: () -> Destination) {
    self = build()
  }

  @resultBuilder
  public enum Builder {

    public static func buildBlock() -> Destination {
      Destination { _ in nil }
    }

    public static func buildExpression(_ expression: Destination) -> Destination {
      expression
    }

    public static func buildPartialBlock(first: Destination) -> Destination {
      first
    }

    public static func buildPartialBlock(
      accumulated: Destination,
      next: Destination
    ) -> Destination {
      Destination { link in
        switch try accumulated.content(for: link) {
        case .some(let view): view
        case .none: try next.content(for: link)
        }
      }
    }
  }
}
