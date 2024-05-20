import CoreGraphics
import SwiftUI

public struct HorizontalAlignment {

    public let id: AlignmentID.Type
    let swiftUI: SwiftUI.HorizontalAlignment
    let builtin: Bool

    public init(
        _ id: AlignmentID.Type,
        swiftUI: SwiftUI.HorizontalAlignment
    ) {
        self.id = id
        self.swiftUI = swiftUI
        self.builtin = false
    }

    init(
        _ id: AlignmentID.Type,
        swiftUI: SwiftUI.HorizontalAlignment,
        builtin: Bool
    ) {
        self.id = id
        self.swiftUI = swiftUI
        self.builtin = builtin
    }

    public static let leading: HorizontalAlignment = HorizontalAlignment(
        HorizontalLeadingAlignment.self,
        swiftUI: .leading,
        builtin: true
    )

    public static let center: HorizontalAlignment = HorizontalAlignment(
        HorizontalCenterAlignment.self,
        swiftUI: .center,
        builtin: true
    )

    public static let trailing: HorizontalAlignment = HorizontalAlignment(
        HorizontalTrailingAlignment.self,
        swiftUI: .trailing,
        builtin: true
    )
}

enum HorizontalLeadingAlignment: AlignmentID {
    static func defaultValue(in context: CGSize) -> CGFloat {
        .zero
    }
}

enum HorizontalCenterAlignment: AlignmentID {
    static func defaultValue(in context: CGSize) -> CGFloat {
        context.width / 2
    }
}

enum HorizontalTrailingAlignment: AlignmentID {
    static func defaultValue(in context: CGSize) -> CGFloat {
        context.width
    }
}
