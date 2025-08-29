import SwiftUI

struct Navigator {

  private let destination: Destination

  init(@Destination.Builder destination: () -> Destination) {
    self.destination = destination()
  }

  func content(for link: Link) -> AnyView? {
    try? destination.content(for: link)
  }
}

extension EnvironmentValues {
  @Entry var navigator: Navigator = Navigator {}
}
