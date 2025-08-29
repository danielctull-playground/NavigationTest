import RegexBuilder
import SwiftUI

public struct ProductID {
  fileprivate let value: Int
}

extension ProductID: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self.init(value: value)
  }
}

private struct PDP: View {

  let id: ProductID

  var body: some View {
    Text("PDP for \(id.value)")
      .navigationTitle("PDP")
  }
}

extension Route<ProductID> {
  fileprivate static var productDetail: Route {
    Route {
      "nav://product/"
      Capture {
        OneOrMore(.digit)
      }
    } transform: { output in
      guard let value = Int(output.1) else { return nil }
      return ProductID(value: value)
    }
  }
}

extension Route<ProductID> {
  fileprivate static var productDetail2: Route {
    Route(domain: "product2", value: .digit) { string in
      guard let value = Int(string) else { return nil }
      return ProductID(value: value)
    }
  }
}

extension Feature {

  public static var productDetail: Feature {
    Feature {
      Destination(route: .productDetail, content: PDP.init)
      Destination(route: .productDetail2, content: PDP.init)
    }
  }
}
