import SwiftUI

class AnyViewBase: BuiltinView {
    func render(context: RenderingContext, size: CGSize) {
        fatalError()
    }

    func size(proposed: ProposedSize) -> CGSize {
        fatalError()
    }
}

class AnyViewImpl<V: View>: AnyViewBase {

    let view: V

    init(view: V) {
        self.view = view
    }

    override func render(context: RenderingContext, size: CGSize) {
        view._render(context: context, size: size)
    }

    override func size(proposed: ProposedSize) -> CGSize {
        view._size(proposed: proposed)
    }
}

public struct AnyView: View, BuiltinView {

    public let swiftUI: SwiftUI.AnyView
    private let impl: AnyViewBase

    public init<V: View>(_ view: V) {
        self.swiftUI = SwiftUI.AnyView(view.swiftUI)
        self.impl = AnyViewImpl(view: view)
    }

    public func render(context: RenderingContext, size: CGSize) {
        impl.render(context: context, size: size)
    }

    public func size(proposed: ProposedSize) -> CGSize {
        impl.size(proposed: proposed)
    }
}
