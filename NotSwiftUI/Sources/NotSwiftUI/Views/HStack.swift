import SwiftUI

public struct HStack: View, BuiltinView {

    let alignment: VerticalAlignment
    let spacing: CGFloat
    let children: [AnyView]
    @LayoutState var sizes: [CGSize] = []

    public init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat = .zero,
        children: [AnyView]
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.children = children
    }


    public func render(context: RenderingContext, size: CGSize) {
        let stackY = alignment.id.defaultValue(in: size)

        var currentX: CGFloat = .zero

        for (childSize, child) in zip(sizes, children) {
            defer { currentX += childSize.width }
            let childY = alignment.id.defaultValue(in: childSize)
            context.saveGState()
            context.translateBy(x: currentX, y: stackY - childY)
            child._render(context: context, size: childSize)
            context.restoreGState()
        }
    }

    public func size(proposed: ProposedSize) -> CGSize {
        layout(proposed: proposed)
        let width = sizes.map(\.width).reduce(0, +)
        let height = sizes.map(\.height).max() ?? .zero
        return CGSize(width: width, height: height)
    }

    private func layout(proposed: ProposedSize) {
        let flexibility = children.map { child in
            let lower = child.size(proposed: ProposedSize(width: .zero, height: proposed.height)).width
            let upper = child.size(proposed: ProposedSize(width: .greatestFiniteMagnitude, height: proposed.height)).width
            return upper - lower
        }

        var remainingIndices = children.indices.sorted { lhs, rhs in
            flexibility[lhs] < flexibility[rhs]
        }

        var remainingWidth = proposed.width! // TODO
        var sizes: [CGSize] = Array(repeating: .zero, count: children.count)

        while !remainingIndices.isEmpty {
            let width = remainingWidth / CGFloat(remainingIndices.count)
            let idx = remainingIndices.removeFirst()
            let child = children[idx]
            let size = child.size(proposed: ProposedSize(
                width: width,
                height: proposed.height
            ))
            sizes[idx] = size
            remainingWidth -= size.width
            if remainingWidth < .zero { remainingWidth = .zero }
        }

        self.sizes = sizes
    }

    public func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        fatalError()
    }

    public var swiftUI: some SwiftUI.View {
        SwiftUI.HStack(alignment: alignment.swiftUI, spacing: spacing) {
            ForEach(children.indices, id: \.self) { idx in
                children[idx].swiftUI
            }
        }
    }
}
