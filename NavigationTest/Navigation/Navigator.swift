import SwiftUI

struct Navigator {

  private let destination: Destination<AnyView>

  init<Content>(@DestinationBuilder destination: @escaping () -> Destination<Content>) {
    self.destination = Destination { link in
      try AnyView(destination().content(for: link))
    }
  }

  func content(for link: Link) -> AnyView? {
    try? destination.content(for: link)
  }
}

extension EnvironmentValues {
  @Entry var navigator: Navigator = Navigator {}
}
