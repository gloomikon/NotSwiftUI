import CoreGraphics
import SwiftUI

struct ForegroundColor<Content: View>: View, BuiltinView {

    let content: Content
    let color: Color

    var layoutPriority: Double {
        content._layoutPriority
    }

    func render(context: RenderingContext, size: CGSize) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        content._render(context: context, size: size)
        context.restoreGState()
    }

    func size(proposed: ProposedSize) -> CGSize {
        content._size(proposed: proposed)
    }

    func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        content._customAlignment(for: alignment, in: size)
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.foregroundColor(SwiftUI.Color(color))
    }
}

public extension View {
    func foregroundColor(_ color: Color) -> some View {
        ForegroundColor(content: self, color: color)
    }
}
