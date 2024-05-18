import CoreGraphics

public struct ProposedSize {

    var width: CGFloat?
    var height: CGFloat?
}

extension ProposedSize {

    init(_ size: CGSize) {
        self.init(width: size.width, height: size.height)
    }

    var orMax: CGSize {
        CGSize(
            width: width ?? .greatestFiniteMagnitude,
            height: height ?? .greatestFiniteMagnitude
        )
    }

    var orDefault: CGSize {
        CGSize(
            width: width ?? 10,
            height: height ?? 10
        )
    }
}
