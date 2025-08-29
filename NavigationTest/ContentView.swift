import SwiftUI

struct ContentView: View {

  @State private var path: [Link] = []
  let navigator: Navigator

  var body: some View {
    VStack {
      NavigationStack(path: $path) {
        NavigationLink(value: Link("https://marksandspencer.com/productlist/12")) {
          Text("Open PLP")
        }
        .navigationDestination(for: Link.self) { link in
          navigator.content(for: link)
        }
      }
      .onOpenURL { url in
        let link = Link(url.absoluteString)
        path.append(link)
      }

      Spacer()

      VStack(spacing: 0) {
        ForEach(path) { link in
          Text(link.string)
        }
      }
    }
    .environment(\.navigator, navigator)
  }
}
