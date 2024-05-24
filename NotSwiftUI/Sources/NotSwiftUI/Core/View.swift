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

    var _layoutPriority: Double {
        if let builtin = self as? BuiltinView {
            builtin.layoutPriority
        } else {
            body._layoutPriority
        }
    }

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

    func _customAlignment(
        for alignment: HorizontalAlignment,
        in size: CGSize
    ) -> CGFloat? {
        if let buildin = self as? BuiltinView {
            buildin.customAlignment(for: alignment, in: size)
        } else {
            body._customAlignment(for: alignment, in: size)
        }
    }
}

extension View {

    func translation<V: View>(
        for childView: V,
        in parentSize: CGSize,
        childSize: CGSize,
        alignment: Alignment
    ) -> CGPoint {
        let parentPoint = alignment.point(for: parentSize)
        var childPoint = alignment.point(for: childSize)

        if let customX = childView._customAlignment(for: alignment.horizontal, in: childSize) {
            childPoint.x = customX
        }

        // TODO: Vertical

        return CGPoint(x: parentPoint.x - childPoint.x, y: parentPoint.y - childPoint.y)
    }

    func translation<V: View>(
        for siblingView: V,
        in size: CGSize,
        siblingSize: CGSize,
        alignment: Alignment
    ) -> CGPoint {
        var selfPoint = alignment.point(for: size)
        var siblingPoint = alignment.point(for: siblingSize)

        if let customX = self._customAlignment(for: alignment.horizontal, in: size) {
            selfPoint.x = customX
        }

        if let customX = siblingView._customAlignment(for: alignment.horizontal, in: siblingSize) {
            siblingPoint.x = customX
        }

        // TODO: Vertical

        return CGPoint(x: selfPoint.x - siblingPoint.x, y: selfPoint.y - siblingPoint.y)
    }
}
