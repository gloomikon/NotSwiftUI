import CoreGraphics
import SwiftUI

public struct VerticalAlignment {

    public let id: AlignmentID.Type
    let swiftUI: SwiftUI.VerticalAlignment
    let builtin: Bool

    public init(
        _ id: AlignmentID.Type,
        swiftUI: SwiftUI.VerticalAlignment
    ) {
        self.id = id
        self.swiftUI = swiftUI
        self.builtin = false
    }

    public init(
        _ id: AlignmentID.Type,
        swiftUI: SwiftUI.VerticalAlignment,
        builtin: Bool
    ) {
        self.id = id
        self.swiftUI = swiftUI
        self.builtin = builtin
    }

    public static let top: VerticalAlignment = VerticalAlignment(
        VerticalTopAlignment.self,
        swiftUI: .top,
        builtin: true
    )

    public static let center: VerticalAlignment = VerticalAlignment(
        VerticalCenterAlignment.self,
        swiftUI: .center,
        builtin: true
    )

    public static let bottom: VerticalAlignment = VerticalAlignment(
        VerticalBottomAlignment.self,
        swiftUI: .bottom,
        builtin: true
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
