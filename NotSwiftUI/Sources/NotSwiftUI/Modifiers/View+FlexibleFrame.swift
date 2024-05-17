import CoreGraphics
import SwiftUI

struct FlexibleFrame<Content: View>: BuiltinView, View {

    let minWidth: CGFloat?
    let idealWidth: CGFloat?
    let maxWidth: CGFloat?
    let minHeight: CGFloat?
    let idealHeight: CGFloat?
    let maxHeight: CGFloat?
    let alignment: Alignment
    let content: Content

    func render(context: RenderingContext, size: ProposedSize) {
        context.saveGState()
        let childSize = content._size(proposed: size)
        context.align(childSize, in: size, alignment: alignment)
        content._render(context: context, size: childSize)
        context.restoreGState()
    }

    func size(proposed: ProposedSize) -> CGSize {
        var proposed = proposed
        
        if let maxWidth, maxWidth < proposed.width {
            proposed.width = maxWidth
        }
        
        if let minWidth, minWidth > proposed.width {
            proposed.width = minWidth
        }

        if let maxHeight, maxHeight < proposed.height {
            proposed.height = maxHeight
        }

        if let minHeight, minHeight > proposed.height {
            proposed.height = minHeight
        }

        var result = content._size(proposed: proposed)

        if let maxWidth {
            result.width = min(maxWidth, max(result.width, proposed.width))
        }

        if let minWidth {
            result.width = max(minWidth, min(result.width, proposed.width))
        }

        if let maxHeight {
            result.height = min(maxHeight, max(result.height, proposed.height))
        }

        if let minHeight {
            result.height = max(minHeight, min(result.height, proposed.height))
        }

        return result
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.frame(
            minWidth: minWidth,
            idealWidth: idealWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            idealHeight: idealHeight,
            maxHeight: maxHeight,
            alignment: alignment.swiftUI
        )
    }
}

public extension View {

    func frame(
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        FlexibleFrame(
            minWidth: minWidth,
            idealWidth: idealWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            idealHeight: idealHeight,
            maxHeight: maxHeight,
            alignment: alignment,
            content: self
        )
    }
}