import SwiftUI

@main
struct NavigationTestApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(navigator: Navigator {
        ProductDetail.destination
        ProductList.destination
      })
    }
  }
}
