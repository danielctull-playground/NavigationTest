
public struct Feature {

  public let destination: Destination

  public init(destination: Destination) {
    self.destination = destination
  }

  public init(@Destination.Builder destination: () -> Destination) {
    self.destination = destination()
  }
}
