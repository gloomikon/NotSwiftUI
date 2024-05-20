import SwiftUI

struct FixedSize<Content: View>: View, BuiltinView {

    let content: Content
    let horizontal: Bool
    let vertical: Bool

    func render(context: RenderingContext, size: CGSize) {
        content._render(context: context, size: size)
    }

    func size(proposed: ProposedSize) -> CGSize {
        var proposed = proposed

        if horizontal {
            proposed.width = nil
        }

        if vertical {
            proposed.height = nil
        }

        return content._size(proposed: proposed)
    }

    func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        content._customAlignment(for: alignment, in: size)
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.fixedSize(horizontal: horizontal, vertical: vertical)
    }
}

public extension View {

    func fixedSize(
        horizontal: Bool = true,
        vertical: Bool = true
    ) -> some View {
        FixedSize(content: self, horizontal: horizontal, vertical: vertical)
    }
}
