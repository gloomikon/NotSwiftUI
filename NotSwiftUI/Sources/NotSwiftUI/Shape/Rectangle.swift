import CoreGraphics

struct Rectangle: Shape {
    func path(in rect: CGRect) -> CGPath {
        CGPath(rect: rect, transform: nil)
    }
}
