import AppKit
import SwiftUI

struct Border<Content: View>: View, BuiltinView {

    let color: NSColor
    let width: CGFloat
    let content: Content

    func render(context: RenderingContext, size: CGSize) {
        content._render(context: context, size: size)
        context.saveGState()
        context.setStrokeColor(color.cgColor)
        context.stroke(
            CGRect(origin: .zero, size: size).insetBy(dx: width / 2, dy: width / 2),
            width: width
        )
        context.restoreGState()
    }

    func size(proposed: ProposedSize) -> CGSize {
        content._size(proposed: proposed)
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.border(Color(color), width: width)
    }
}

public extension View {
    func border(_ color: NSColor, width: CGFloat) -> some View {
        Border(color: color, width: width, content: self)
    }
}
