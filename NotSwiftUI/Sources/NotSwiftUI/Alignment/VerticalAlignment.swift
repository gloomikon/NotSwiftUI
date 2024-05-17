import CoreGraphics
import SwiftUI

public struct VerticalAlignment {

    public let id: AlignmentID.Type
    let swiftUI: SwiftUI.VerticalAlignment

    public init(
        _ id: AlignmentID.Type,
        swiftUI: SwiftUI.VerticalAlignment
    ) {
        self.id = id
        self.swiftUI = swiftUI
    }

    public static let top: VerticalAlignment = VerticalAlignment(
        VerticalTopAlignment.self,
        swiftUI: .top
    )

    public static let center: VerticalAlignment = VerticalAlignment(
        VerticalCenterAlignment.self,
        swiftUI: .center
    )

    public static let bottom: VerticalAlignment = VerticalAlignment(
        VerticalBottomAlignment.self,
        swiftUI: .bottom
    )
}

enum VerticalTopAlignment: AlignmentID {
    static func defaultValue(in context: CGSize) -> CGFloat {
        context.height
    }
}

enum VerticalCenterAlignment: AlignmentID {
    static func defaultValue(in context: CGSize) -> CGFloat {
        context.height / 2
    }
}

enum VerticalBottomAlignment: AlignmentID {
    static func defaultValue(in context: CGSize) -> CGFloat {
        .zero
    }
}
