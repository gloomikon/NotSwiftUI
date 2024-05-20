import CoreGraphics
import SwiftUI

struct FixedFrame<Content: View>: BuiltinView, View {

    let width: CGFloat?
    let height: CGFloat?
    let alignment: Alignment
    let content: Content
    
    func render(context: RenderingContext, size: CGSize) {
        context.saveGState()
        let childSize = content._size(proposed: ProposedSize(size))
        let translation = translation(
            for: content,
            in: size,
            childSize: childSize,
            alignment: alignment
        )
        context.translateBy(x: translation.x, y: translation.y)
        content._render(context: context, size: childSize)
        context.restoreGState()
    }
    
    func size(proposed: ProposedSize) -> CGSize {
        if let width, let height {
            return CGSize(width: width, height: height)
        }
        
        let childSize = content._size(
            proposed: ProposedSize(
                width: width ?? proposed.width,
                height: height ?? proposed.height
            )
        )
        
        return CGSize(width: width ?? childSize.width, height: height ?? childSize.height)
    }

    func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        let childSize = content._size(proposed: ProposedSize(size))

        if let customX = content._customAlignment(for: alignment, in: childSize) {
            let translation = translation(
                for: content,
                in: size,
                childSize: childSize,
                alignment: self.alignment
            )

            return translation.x + customX
        }

        return nil
    }

    var swiftUI: some SwiftUI.View {
        content.swiftUI.frame(
            width: width,
            height: height,
            alignment: alignment.swiftUI
        )
    }
}

public extension View {
    func frame(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        FixedFrame(width: width, height: height, alignment: alignment, content: self)
    }
}
