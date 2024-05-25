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

    public var layoutPriority: Double {
        .zero
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

    func layout(proposed: ProposedSize) {
        let flexibility: [LayoutInfo] = children.enumerated().map { idx, child in
            let lower = child.size(proposed: ProposedSize(width: .zero, height: proposed.height)).width
            let upper = child.size(proposed: ProposedSize(width: 1e15, height: proposed.height)).width
            return LayoutInfo(
                minWidth: lower,
                maxWidth: upper,
                idx: idx,
                priority: child.layoutPriority
            )
        }.sorted()

        var groups = flexibility.group(by: \.priority)
        var sizes: [CGSize] = Array(repeating: .zero, count: children.count)
        let allMinWidth = flexibility.map(\.minWidth).reduce(0, +)
        var remainingWidth = proposed.width! - allMinWidth // TODO: - Force unwrap

        while !groups.isEmpty {
            let group = groups.removeFirst()
            remainingWidth += group.map(\.minWidth).reduce(0, +)
            var remainingIndices = group.map(\.idx)

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
        }

        self.sizes = sizes
    }

    public func customAlignment(
        for alignment: HorizontalAlignment,
        in size: CGSize
    ) -> CGFloat? {
        if alignment.builtin { return nil }

        var currentX: CGFloat = .zero
        var values: [CGFloat] = []

        for (childSize, child) in zip(sizes, children) {
            defer { currentX += childSize.width }

            if let value = child.customAlignment(for: alignment, in: childSize) {
                values.append(value + currentX)
            }
        }

        return values.average
    }

    public var swiftUI: some SwiftUI.View {
        SwiftUI.HStack(alignment: alignment.swiftUI, spacing: spacing) {
            ForEach(children.indices, id: \.self) { idx in
                children[idx].swiftUI
            }
        }
    }
}

private extension Array where Element: FloatingPoint {
    var average: Element? {
        if isEmpty { return nil }
        let factor = 1 / Element(count)
        return map { $0 * factor }.reduce(0, +)
    }
}
