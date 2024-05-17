import CoreGraphics
import SwiftUI

extension Alignment {
    func point(for size: CGSize) -> CGPoint {
        let x = horizontal.id.defaultValue(in: size)
        let y = vertical.id.defaultValue(in: size)
        return CGPoint(x: x, y: y)
    }
}

struct FixedFrame<Content: View>: BuiltinView, View {

    let width: CGFloat?
    let height: CGFloat?
    let alignment: Alignment
    let content: Content
    
    func render(context: RenderingContext, size: ProposedSize) { 
        context.saveGState()
        let childSize = content._size(proposed: size)

        let selfPoint = alignment.point(for: size)
        let childPoint = alignment.point(for: childSize)

        context.translateBy(
            x: selfPoint.x - childPoint.x,
            y: selfPoint.y - childPoint.y
        )

        content._render(context: context, size: childSize)
        context.restoreGState()
    }
    
    func size(proposed: ProposedSize) -> CGSize {
        if let width, let height {
            return CGSize(width: width, height: height)
        }
        
        let childSize = content._size(
            proposed: CGSize(
                width: width ?? proposed.width,
                height: height ?? proposed.height
            )
        )
        
        return CGSize(width: width ?? childSize.width, height: height ?? childSize.height)
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
    func frame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        FixedFrame(width: width, height: height, alignment: alignment, content: self)
    }
}
