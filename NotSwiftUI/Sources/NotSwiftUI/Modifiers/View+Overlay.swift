import SwiftUI

struct Overlay<Content: View, Overlay: View>: View, BuiltinView {

    let content: Content
    let overlay: Overlay
    let alignment: Alignment

    func render(context: RenderingContext, size: CGSize) {
        content._render(context: context, size: size)
        let contentSize = content._size(proposed: size)
        let childSize = overlay._size(proposed: contentSize)
        context.saveGState()
        overlay._render(context: context, size: childSize)
        context.restoreGState()
    }

    func size(proposed: ProposedSize) -> CGSize {
        content._size(proposed: proposed)
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
