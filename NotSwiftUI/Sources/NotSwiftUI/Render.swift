import Foundation
import CoreGraphics

public func render<V: View>(view: V) -> Data {
    let size = CGSize(width: 600, height: 400)
    return CGContext.pdf(size: size) { context in
        view.render(context: context, size: size)
    }
}
