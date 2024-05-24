import SwiftUI

class AnyViewBase: BuiltinView {

    var layoutPriority: Double {
        fatalError()
    }

    func render(context: RenderingContext, size: CGSize) {
        fatalError()
    }

    func size(proposed: ProposedSize) -> CGSize {
        fatalError()
    }

    func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        fatalError()
    }
}

class AnyViewImpl<V: View>: AnyViewBase {

    let view: V

    init(view: V) {
        self.view = view
    }

    override var layoutPriority: Double {
        view._layoutPriority
    }

    override func render(context: RenderingContext, size: CGSize) {
        view._render(context: context, size: size)
    }

    override func size(proposed: ProposedSize) -> CGSize {
        view._size(proposed: proposed)
    }

    override func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        view._customAlignment(for: alignment, in: size)
    }
}

public struct AnyView: View, BuiltinView {

    public let swiftUI: SwiftUI.AnyView
    private let impl: AnyViewBase

    public init<V: View>(_ view: V) {
        self.swiftUI = SwiftUI.AnyView(view.swiftUI)
        self.impl = AnyViewImpl(view: view)
    }

    public var layoutPriority: Double {
        impl.layoutPriority
    }

    public func render(context: RenderingContext, size: CGSize) {
        impl.render(context: context, size: size)
    }

    public func size(proposed: ProposedSize) -> CGSize {
        impl.size(proposed: proposed)
    }

    public func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        impl.customAlignment(for: alignment, in: size)
    }
}
