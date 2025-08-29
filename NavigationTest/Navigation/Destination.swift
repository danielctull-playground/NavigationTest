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
