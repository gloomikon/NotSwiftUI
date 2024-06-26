import CoreGraphics

public protocol BuiltinView {
    typealias Body = Never

    var layoutPriority: Double { get }

    func render(context: RenderingContext, size: CGSize)

    func size(proposed: ProposedSize) -> CGSize

    func customAlignment(
        for alignment: HorizontalAlignment,
        in size: CGSize
    ) -> CGFloat?
}
