import AppKit
import SwiftUI

public protocol Shape: View {
    func path(in rect: CGRect) -> CGPath
}

public extension Shape {
    var body: some View {
        ShapeView(shape: self)
    }
    
    var swiftUI: some SwiftUI.View {
        AnyShape(self)
    }
}

struct AnyShape: SwiftUI.Shape {
    
    private let path: (CGRect) -> CGPath
    
    init<S: Shape>(_ shape: S) {
        path = shape.path(in:)
    }
    
    func path(in rect: CGRect) -> Path {
        Path(path(rect))
    }
}

public struct ShapeView<S: Shape>: BuiltinView, View {

    let shape: S

    public var layoutPriority: Double {
        .zero
    }

    public func render(context: RenderingContext, size: CGSize) {
        context.saveGState()
        context.addPath(shape.path(in: CGRect(origin: .zero, size: size)))
        context.fillPath()
        context.restoreGState()
    }
    
    public func size(proposed: ProposedSize) -> CGSize {
        proposed.orDefault
    }

    public func customAlignment(
        for alignment: HorizontalAlignment,
        in size: CGSize
    ) -> CGFloat? {
        nil
    }

    public var swiftUI: some SwiftUI.View {
        AnyShape(shape)
    }
}
