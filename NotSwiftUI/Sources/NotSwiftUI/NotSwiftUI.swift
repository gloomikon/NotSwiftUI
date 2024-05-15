public protocol BuiltinView {
    func render(context: RenderingContext, size: ProposedSize)
    typealias Body = Never
}
