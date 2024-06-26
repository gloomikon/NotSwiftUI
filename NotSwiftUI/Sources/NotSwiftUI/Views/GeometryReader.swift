import SwiftUI

public struct GeometryReader<Content: View>: View, BuiltinView {

    let content: (CGSize) -> Content

    public init(content: @escaping (CGSize) -> Content) {
        self.content = content
    }

    public var layoutPriority: Double {
        .zero
    }

    public func render(context: RenderingContext, size: CGSize) {
         content(size)._render(context: context, size: size)
    }

    public func size(proposed: ProposedSize) -> CGSize {
        proposed.orDefault
    }

    public func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        nil
    }

    public var swiftUI: some SwiftUI.View {
        SwiftUI.GeometryReader { proxy in
            content(proxy.size).swiftUI
        }
    }
}
