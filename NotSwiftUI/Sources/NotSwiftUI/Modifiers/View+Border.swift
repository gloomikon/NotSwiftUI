import CoreGraphics
import SwiftUI

struct BorderShape: Shape {

    let width: CGFloat

    func path(in rect: CGRect) -> CGPath {
        CGPath(rect: rect.insetBy(dx: width / 2, dy: width / 2), transform: nil)
            .copy(
                strokingWithWidth: width,
                lineCap: .butt,
                lineJoin: .miter,
                miterLimit: 10
            )
    }
}

public extension View {
    func border(_ color: Color, width: CGFloat = 1) -> some View {
        overlay(BorderShape(width: width).foregroundColor(color))
    }
}
