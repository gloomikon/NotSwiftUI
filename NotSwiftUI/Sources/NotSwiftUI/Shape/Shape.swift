import AppKit

public protocol Shape: View {
    func path(in rect: CGRect) -> CGPath
}

public extension Shape {
    var body: some View {
        ShapeView(shape: self)
    }
}

public struct ShapeView<S: Shape>: BuiltinView, View {
    
    let shape: S
    let color: NSColor
    
    init(shape: S, color: NSColor = .red) {
        self.shape = shape
        self.color = color
    }
    
    public func render(context: RenderingContext, size: ProposedSize) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.addPath(shape.path(in: CGRect(origin: .zero, size: size)))
        context.fillPath()
        context.restoreGState()
    }
}
