import SwiftUI

public struct Destination {

  let content: (Link) throws -> AnyView?

  public init<Value, Content: View>(
    route: Route<Value>,
    @ViewBuilder content: @escaping (Value) -> Content
  ) {
    self.content = { link in
      guard let value = try route.value(for: link) else { return nil }
      return AnyView(content(value))
    }
  }
}

// MARK: - Destinations

public struct Destinations {
  let values: [Destination]

  fileprivate init(values: [Destination]) {
    self.values = values
  }

  public init(@Destinations.Builder build: () -> Destinations) {
    self = build()
  }
}

extension Destinations {
  @resultBuilder
  public enum Builder {

    public static func buildBlock() -> Destinations {
      Destinations(values: [])
    }

    public static func buildExpression(_ expression: Destination) -> Destinations {
      Destinations(values: [expression])
    }

    public static func buildExpression(_ expression: Destinations) -> Destinations {
      expression
    }

    public static func buildPartialBlock(first: Destinations) -> Destinations {
      first
    }

    public static func buildPartialBlock(
      accumulated: Destinations,
      next: Destinations
    ) -> Destinations {
      Destinations(values: accumulated.values + next.values)
    }
  }
}
