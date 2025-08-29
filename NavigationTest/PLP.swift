import RegexBuilder
import SwiftUI

private struct ProductListID {
  let value: Int
}

extension Link {
  public static func productDetail(_ id: Int) -> Link {
    .navigation(domain: "product", value: "\(id)")
  }
}

extension Link {
  public static func productDetail2(_ id: Int) -> Link {
    .navigation(domain: "product2", value: "\(id)")
  }
}

private struct PLP: View {

  let id: ProductListID

  var body: some View {

    List {
      NavigationLink("Product 1", value: Link.productDetail(1))
      NavigationLink("Product 2", value: Link.productDetail(2))
      NavigationLink("Product 3", value: Link.productDetail(3))
      NavigationLink("Product 4", value: Link.productDetail(4))
      NavigationLink("Product 5", value: Link.productDetail(5))
      NavigationLink("Product 11", value: Link.productDetail2(11))
      NavigationLink("Product 12", value: Link.productDetail2(12))
      NavigationLink("Product 13", value: Link.productDetail2(13))
      NavigationLink("Product 14", value: Link.productDetail2(14))
      NavigationLink("Product 15", value: Link.productDetail2(15))


      Embed(link: .productDetail(1000))

      ZStack {
        Color.yellow
          .frame(width: 10, height: 10)
        Embed(link: Link(""))
      }
      .padding()
    }
    .navigationTitle(Text("PLP \(id.value)"))
  }
}

extension Route<ProductListID> {
  fileprivate static var productList: Route {
    Route {
      "https://marksandspencer.com/productlist/"
      Capture {
        OneOrMore(.digit)
      }
    } transform: { output in
      guard let value = Int(output.1) else { return nil }
      return ProductListID(value: value)
    }
  }
}

extension Feature {

  public static var productList: Feature {
    Feature(destinations: Destinations {
      Destination(route: .productList, content: PLP.init)
    })
  }
}
