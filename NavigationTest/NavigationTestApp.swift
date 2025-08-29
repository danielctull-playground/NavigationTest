import SwiftUI

@main
struct NavigationTestApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(navigator: Navigator {
        Feature.productDetail.destination
        Feature.productList.destination
      })
    }
  }
}
