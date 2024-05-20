import SwiftUI

struct CustomHAlignmentGuide<Content: View>: View, BuiltinView {

    let content: Content
    let alignment: HorizontalAlignment
    let computeValue: (CGSize) -> CGFloat

    func render(context: RenderingContext, size: CGSize) {
        content._render(context: context, size: size)
    }

    func size(proposed: ProposedSize) -> CGSize {
        content._size(proposed: proposed)
    }

    func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        if alignment.id == self.alignment.id {
            computeValue(size)
        } else {
            content._customAlignment(for: alignment, in: size)
        }
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI
            .alignmentGuide(alignment.swiftUI) {
                computeValue(CGSize(width: $0.width, height: $0.height))
            }
    }
}

public extension View {

    func alignmentGuide(
        _ alignment: HorizontalAlignment,
        computeValue: @escaping (CGSize) -> CGFloat
    ) -> some View {
        CustomHAlignmentGuide(content: self, alignment: alignment, computeValue: computeValue)
    }
}
