import Foundation
import CoreGraphics

public func render<V: View>(view: V, size: CGSize) -> Data {
    CGContext.pdf(size: size) { context in
        view
            .frame(width: size.width, height: size.height)
            ._render(context: context, size: size)
    }
}
