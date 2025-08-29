import SwiftUI

@main
struct NavigationTestApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(navigator: Navigator {
        Feature.productDetail.destinations
        Feature.productList.destinations
      })
    }
  }
}
