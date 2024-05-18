import SwiftUI

public struct HStack: View, BuiltinView {

    let alignment: VerticalAlignment
    let spacing: CGFloat
    let children: [AnyView]

    public init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat = 8,
        children: [AnyView]
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.children = children
    }


    public func render(context: RenderingContext, size: CGSize) {
        let sizes = layout(proposed: ProposedSize(size))

        var currentX: CGFloat = .zero

        for (childSize, child) in zip(sizes, children) {
            defer { currentX += childSize.width }
            context.saveGState()
            context.translateBy(x: currentX, y: .zero)
            child._render(context: context, size: childSize)
            context.restoreGState()
        }
    }

    public func size(proposed: ProposedSize) -> CGSize {
        let sizes = layout(proposed: proposed)
        let width = sizes.map(\.width).reduce(0, +)
        let height = sizes.map(\.height).max() ?? .zero
        return CGSize(width: width, height: height)
    }

    private func layout(proposed: ProposedSize) -> [CGSize] {
        var remainingWidth = proposed.width! // TODO
        var remaining = children
        var sizes: [CGSize] = []

        while !remaining.isEmpty {
            let width = remainingWidth / CGFloat(remaining.count)
            let child = remaining.removeFirst()
            let size = child.size(proposed: ProposedSize(
                width: width,
                height: proposed.height
            ))
            sizes.append(size)
            remainingWidth -= size.width
        }

        return sizes
    }

    public var swiftUI: some SwiftUI.View {
        SwiftUI.HStack(alignment: alignment.swiftUI, spacing: spacing) {
            ForEach(children.indices, id: \.self) { idx in
                children[idx].swiftUI
            }
        }
    }
}
