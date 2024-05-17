import CoreGraphics
import SwiftUI

struct FixedFrame<Content: View>: BuiltinView, View {

    let width: CGFloat?
    let height: CGFloat?
    let content: Content
    
    func render(context: RenderingContext, size: ProposedSize) { 
        context.saveGState()
        let childSize = content._size(proposed: size)
        context.translateBy(
            x: (size.width - childSize.width) / 2,
            y: (size.height - childSize.height) / 2
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
        content.swiftUI.frame(width: width, height: height)
    }
}

public extension View {
    func frame(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        FixedFrame(width: width, height: height, content: self)
    }
}