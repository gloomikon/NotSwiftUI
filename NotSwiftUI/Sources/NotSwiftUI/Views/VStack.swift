import SwiftUI

public struct VStack: View, BuiltinView {

    let alignment: HorizontalAlignment
    let spacing: CGFloat
    let children: [AnyView]
    @LayoutState var sizes: [CGSize] = []

    public init(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat = .zero,
        children: [AnyView]
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.children = children
    }


    public func render(context: RenderingContext, size: CGSize) {
        let stackX = alignment.id.defaultValue(in: size)

        var currentY: CGFloat = .zero

        for (childSize, child) in zip(sizes, children).reversed() {
            defer { currentY += childSize.height }
            let childX = alignment.id.defaultValue(in: childSize)
            context.saveGState()
            context.translateBy(x: stackX - childX, y: currentY)
            child._render(context: context, size: childSize)
            context.restoreGState()
        }
    }

    public func size(proposed: ProposedSize) -> CGSize {
        layout(proposed: proposed)
        let width = sizes.map(\.width).max() ?? .zero
        let height = sizes.map(\.height).reduce(.zero, +)
        return CGSize(width: width, height: height)
    }

    private func layout(proposed: ProposedSize) {
        let flexibility = children.map { child in
            let lower = child.size(proposed: ProposedSize(width: proposed.width, height: .zero)).height
            let upper = child.size(proposed: ProposedSize(width: proposed.width, height: .greatestFiniteMagnitude)).height
            return upper - lower
        }

        var remainingIndices = children.indices.sorted { lhs, rhs in
            flexibility[lhs] < flexibility[rhs]
        }

        var remainingWidth = proposed.height! // TODO
        var sizes: [CGSize] = Array(repeating: .zero, count: children.count)

        while !remainingIndices.isEmpty {
            let height = remainingWidth / CGFloat(remainingIndices.count)
            let idx = remainingIndices.removeFirst()
            let child = children[idx]
            let size = child.size(proposed: ProposedSize(
                width: proposed.width,
                height: height
            ))
            sizes[idx] = size
            remainingWidth -= size.height
            if remainingWidth < .zero { remainingWidth = .zero }
        }

        self.sizes = sizes
    }

    public var swiftUI: some SwiftUI.View {
        SwiftUI.VStack(alignment: alignment.swiftUI, spacing: spacing) {
            ForEach(children.indices, id: \.self) { idx in
                children[idx].swiftUI
            }
        }
    }
}
