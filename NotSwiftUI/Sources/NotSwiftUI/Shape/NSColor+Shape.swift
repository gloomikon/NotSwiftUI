import AppKit

extension NSColor: View {
    public var body: some View {
        ShapeView(shape: Rectangle(), color: self)
    }
}
