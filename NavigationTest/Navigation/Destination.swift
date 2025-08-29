import SwiftUI

public struct Destination<Content: View> {

  private let content: (Link) throws -> Content?

  init(@ViewBuilder content: @escaping (Link) throws -> Content?) {
    self.content = content
  }
}

extension Destination {

  public init<Value>(
    route: Route<Value>,
    @ViewBuilder content: @escaping (Value) -> Content
  ) {
    self.init { link in
      if let value = try route.value(for: link) {
        content(value)
      }
    }
  }

  public func content(for link: Link) throws -> Content? {
    try content(link)
  }
}

extension Destination {

  public init(@DestinationBuilder build: () -> Destination) {
    self = build()
  }
}

@resultBuilder
public enum DestinationBuilder {

  public static func buildBlock() -> Destination<Never> {
    Destination { _ in Optional<Never>.none }
  }

  public static func buildPartialBlock<C>(
    first: Destination<C>
  ) -> Destination<C> {
    first
  }

  public static func buildPartialBlock<C1, C2>(
    accumulated: Destination<C1>,
    next: Destination<C2>
  ) -> Destination<_ConditionalContent<C2,C1?>> {
    Destination<_ConditionalContent<C2,C1?>> { link in
      if let content = try next.content(for: link) {
        content
      } else {
        try accumulated.content(for: link)
      }
    }
  }
}
