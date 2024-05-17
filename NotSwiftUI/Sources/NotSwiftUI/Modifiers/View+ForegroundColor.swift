import CoreGraphics
import SwiftUI

struct ForegroundColor<Content: View>: View, BuiltinView {

    let content: Content
    let color: NSColor

    func render(context: RenderingContext, size: CGSize) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        content._render(context: context, size: size)
        context.restoreGState()
    }

    func size(proposed: ProposedSize) -> CGSize {
        content._size(proposed: proposed)
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.foregroundColor(Color(color))
    }
}

public extension View {
    func foregroundColor(_ color: NSColor) -> some View {
        ForegroundColor(content: self, color: color)
    }
}
