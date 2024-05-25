import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct VGrid: View, BuiltinView {

    let columns: [CGFloat]
    let content: [AnyView]

    public init(columns: [CGFloat], content: [AnyView]) {
        self.columns = columns
        self.content = content
    }

    public func render(context: RenderingContext, size: CGSize) {
        var offsetY: CGFloat = .zero
        var remainingViews = content
        while !remainingViews.isEmpty {
            var offsetX: CGFloat = .zero
            let lineViews = remainingViews.prefix(columns.count)
            remainingViews.removeFirst(lineViews.count)
            let lineHeight = zip(columns, lineViews)
                .map { column, view in
                    view.size(proposed: ProposedSize(width: column, height: nil))
                }
                .map(\.height)
                .max() ?? .zero

            for (column, view) in zip(columns, lineViews) {
                let childSize = view.size(proposed: ProposedSize(width: column, height: lineHeight))
                context.saveGState()
                context.translateBy(x: offsetX, y: offsetY)
                view.render(context: context, size: childSize)
                context.restoreGState()
                offsetX += childSize.width
            }

            offsetY += lineHeight
        }
    }

    public func size(proposed: ProposedSize) -> CGSize {
        let width = columns.reduce(0, +)
        var height: CGFloat = .zero
        var remainingViews = content
        while !remainingViews.isEmpty {
            let lineViews = remainingViews.prefix(columns.count)
            remainingViews.removeFirst(lineViews.count)
            let lineHeight = zip(columns, lineViews)
                .map { column, view in
                    view.size(proposed: ProposedSize(width: column, height: nil))
                }
                .map(\.height)
                .max() ?? .zero
            height += lineHeight
        }

        return CGSize(width: max(proposed.orDefault.width, width), height: height)
    }

    public var swiftUI: some SwiftUI.View {
        LazyVGrid(
            columns: columns.map { GridItem(.fixed($0), spacing: .zero) },
            alignment: .leading,
            spacing: .zero
        ) {
            ForEach(content.indices, id: \.self) { idx in
                content[idx].swiftUI
            }
        }
    }

    public var layoutPriority: Double {
        .zero
    }

    public func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        nil
    }
}
