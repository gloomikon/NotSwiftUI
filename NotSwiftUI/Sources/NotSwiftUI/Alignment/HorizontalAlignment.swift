import CoreGraphics
import SwiftUI

public struct HorizontalAlignment {

    public let id: AlignmentID.Type
    let swiftUI: SwiftUI.HorizontalAlignment

    public init(
        _ id: AlignmentID.Type,
        swiftUI: SwiftUI.HorizontalAlignment
    ) {
        self.id = id
        self.swiftUI = swiftUI
    }

    public static let leading: HorizontalAlignment = HorizontalAlignment(
        HorizontalLeadingAlignment.self, 
        swiftUI: .leading
    )

    public static let center: HorizontalAlignment = HorizontalAlignment(
        HorizontalCenterAlignment.self,
        swiftUI: .center
    )

    public static let trailing: HorizontalAlignment = HorizontalAlignment(
        HorizontalTrailingAlignment.self,
        swiftUI: .trailing
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
