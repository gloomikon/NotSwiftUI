import CoreGraphics
import SwiftUI

public struct Ellipse: Shape {

    public init() { }
    
    public func path(in rect: CGRect) -> CGPath {
        CGPath(ellipseIn: rect, transform: nil)
    }
}

