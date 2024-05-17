import CoreGraphics

extension RenderingContext {
    func align(_ childSize: CGSize, in parentSize: CGSize, alignment: Alignment) {
        let parentPoint = alignment.point(for: parentSize)
        let childPoint = alignment.point(for: childSize)

        translateBy(
            x: parentPoint.x - childPoint.x,
            y: parentPoint.y - childPoint.y
        )
    }
}

