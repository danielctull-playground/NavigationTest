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
