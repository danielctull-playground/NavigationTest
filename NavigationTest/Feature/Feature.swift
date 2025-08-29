import SwiftUI

protocol Feature {
  associatedtype Content: View
  static var destination: Destination<Content> { get }
}

//public struct Feature<Content: View> {
//
//  public let destination: Destination<Content>
//
//  public init(destination: Destination<Content>) {
//    self.destination = destination
//  }
//
//  public init(@DestinationBuilder destination: () -> Destination<Content>) {
//    self.destination = destination()
//  }
//}
