import SwiftUI

struct Navigator {
  
  private let destinations: Destinations

  init(@Destinations.Builder destinations: () -> Destinations) {
    self.destinations = destinations()
  }

  func content(for link: Link) -> some View {
    destinations.values
      .lazy
      .compactMap { try? $0.content(link) }
      .first
  }
}

extension EnvironmentValues {
  @Entry var navigator: Navigator = Navigator {}
}

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
