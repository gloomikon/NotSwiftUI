import CoreGraphics
import SwiftUI

struct LayoutPriority<Content: View>: View, BuiltinView {

    let content: Content
    let layoutPriority: Double

    func render(context: RenderingContext, size: CGSize) {
        content._render(context: context, size: size)
    }

    func size(proposed: ProposedSize) -> CGSize {
        content._size(proposed: proposed)
    }

    func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        content._customAlignment(for: alignment, in: size)
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.layoutPriority(layoutPriority)
    }
}

public extension View {
    func layoutPriority(_ value: Double) -> some View {
        LayoutPriority(content: self, layoutPriority: value)
    }
}
