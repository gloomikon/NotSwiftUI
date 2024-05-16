import CoreGraphics

public struct Rectangle: Shape {
    public func path(in rect: CGRect) -> CGPath {
        CGPath(rect: rect, transform: nil)
    }
    
    public init() { }
}
