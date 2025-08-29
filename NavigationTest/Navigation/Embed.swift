import SwiftUI


struct Embed: View {

  @Environment(\.navigator) private var navigator

  let link: Link

  var body: some View {
    navigator.content(for: link)
  }
}
