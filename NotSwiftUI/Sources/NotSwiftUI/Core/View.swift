import CoreGraphics
import SwiftUI

public protocol View {
    associatedtype Body: View
    var body: Body { get }
    
    associatedtype SwiftUIView: SwiftUI.View
    var swiftUI: SwiftUIView { get }
}

public extension View where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: View {
    public typealias Body = Never
    public var swiftUI: Never { fatalError("This should never be called.") }
}

extension View {
    func _render(context: RenderingContext, size: CGSize) {
        if let builtin = self as? BuiltinView {
            builtin.render(context: context, size: size)
        } else {
            body._render(context: context, size: size)
        }
    }
    
    func _size(proposed: ProposedSize) -> CGSize {
        if let buildin = self as? BuiltinView {
            buildin.size(proposed: proposed)
        } else {
            body._size(proposed: proposed)
        }
    }
}
