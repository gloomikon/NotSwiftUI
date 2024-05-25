import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct VGrid: View, BuiltinView {

    let columns: [GridItem.Size]
    let content: [AnyView]

    public init(columns: [GridItem.Size], content: [AnyView]) {
        self.columns = columns
        self.content = content
    }

    public func render(context: RenderingContext, size: CGSize) {
        let columnWidths = layoutColumns(size.width)
        var offsetY: CGFloat = .zero
        var remainingViews = content
        while !remainingViews.isEmpty {
            var offsetX: CGFloat = .zero
            let lineViews = remainingViews.prefix(columnWidths.count)
            remainingViews.removeFirst(lineViews.count)
            let lineHeight = zip(columnWidths, lineViews)
                .map { width, view in
                    view.size(proposed: ProposedSize(width: width, height: nil))
                }
                .map(\.height)
                .max() ?? .zero

            for (width, view) in zip(columnWidths, lineViews) {
                let childSize = view.size(proposed: ProposedSize(width: width, height: lineHeight))
                context.saveGState()
                context.translateBy(x: offsetX, y: offsetY)
                view.render(context: context, size: childSize)
                context.restoreGState()
                offsetX += childSize.width
            }

            offsetY += lineHeight
        }
    }

    private func layoutColumns(_ width: CGFloat) -> [CGFloat] {
        var remainingIndices = columns.indices.sorted { lhs, rhs in
            if case .fixed = columns[lhs] { return true }
            if case .fixed = columns[rhs] { return false }
            return lhs < rhs
        }

        var result = Array(repeating: .zero as CGFloat, count: columns.count)

        var remainingWidth = width
        while !remainingIndices.isEmpty {
            let proposedWidth = remainingWidth / CGFloat(remainingIndices.count)

            let idx = remainingIndices.removeFirst()

            let columnWidth = switch columns[idx] {
            case let .fixed(width):
                width
            case let .flexible(minimum, maximum):
                min(max(minimum, proposedWidth), maximum)
            case .adaptive:
                fatalError()
            }

            result[idx] = columnWidth
            remainingWidth -= columnWidth
        }

        return result
    }

    public func size(proposed: ProposedSize) -> CGSize {
        let columnWidths = layoutColumns(proposed.orDefault.width)
        let width = columnWidths.reduce(0, +)
        var height: CGFloat = .zero
        var remainingViews = content
        while !remainingViews.isEmpty {
            let lineViews = remainingViews.prefix(columns.count)
            remainingViews.removeFirst(lineViews.count)
            let lineHeight = zip(columnWidths, lineViews)
                .map { width, view in
                    view.size(proposed: ProposedSize(width: width, height: nil))
                }
                .map(\.height)
                .max() ?? .zero
            height += lineHeight
        }

        return CGSize(width: max(proposed.orDefault.width, width), height: height)
    }

    public var swiftUI: some SwiftUI.View {
        LazyVGrid(
            columns: columns.map { GridItem($0, spacing: .zero) },
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
