import SwiftUI

public struct GeometryReader<Content: View>: View, BuiltinView {

    let content: (CGSize) -> Content

    public init(content: @escaping (CGSize) -> Content) {
        self.content = content
    }

    public func render(context: RenderingContext, size: CGSize) {
         // Top leading alignment
         content(size)._render(context: context, size: size)

        // Center alignment
//        let child = content(size)
//        let childSize = child._size(proposed: size)
//        context.saveGState()
//        context.align(
//            childSize,
//            in: size,
//            alignment: .center
//        )
//        content(size)._render(context: context, size: childSize)
//        context.restoreGState()
    }

    public func size(proposed: ProposedSize) -> CGSize {
        proposed
    }

    public var swiftUI: some SwiftUI.View {
        SwiftUI.GeometryReader { proxy in
            content(proxy.size).swiftUI
        }
    }
}
