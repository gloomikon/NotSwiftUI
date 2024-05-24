import SwiftUI

struct Overlay<Content: View, Overlay: View>: View, BuiltinView {

    let content: Content
    let overlay: Overlay
    let alignment: Alignment

    var layoutPriority: Double {
        content._layoutPriority
    }

    func render(context: RenderingContext, size: CGSize) {
        content._render(context: context, size: size)
        let contentSize = content._size(proposed: ProposedSize(size))
        let childSize = overlay._size(proposed: ProposedSize(contentSize))
        context.saveGState()
        let translation = content.translation(
            for: overlay,
            in: size,
            siblingSize: childSize,
            alignment: alignment
        )
        context.translateBy(x: translation.x, y: translation.y)
        overlay._render(context: context, size: childSize)
        context.restoreGState()
    }

    func size(proposed: ProposedSize) -> CGSize {
        content._size(proposed: proposed)
    }

    func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        content._customAlignment(for: alignment, in: size)
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.overlay(overlay.swiftUI, alignment: alignment.swiftUI)
    }
}

public extension View {

    func overlay<O: View>(
        _ overlay: O,
        alignment: Alignment = .center
    ) -> some View {
        Overlay(content: self, overlay: overlay, alignment: alignment)
    }
}
