public protocol View {
    associatedtype Body: View
    var body: Body { get }
}

public extension View where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: View {
    public typealias Body = Never
}

public extension View {
    func render(context: RenderingContext, size: ProposedSize) {
        if let builtin = self as? BuiltinView {
            builtin.render(context: context, size: size)
        } else {
            body.render(context: context, size: size)
        }
    }
}
