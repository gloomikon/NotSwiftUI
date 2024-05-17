import SwiftUI

public struct Alignment {

    public let horizontal: HorizontalAlignment
    public let vertical: VerticalAlignment

    public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) {
        self.horizontal = horizontal
        self.vertical = vertical
    }

    var swiftUI: SwiftUI.Alignment {
        SwiftUI.Alignment(
            horizontal: horizontal.swiftUI,
            vertical: vertical.swiftUI
        )
    }

    public static let topLeading: Alignment = Alignment(horizontal: .leading, vertical: .top)
    public static let top: Alignment = Alignment(horizontal: .center, vertical: .top)
    public static let topTrailing: Alignment = Alignment(horizontal: .trailing, vertical: .top)
    public static let leading: Alignment = Alignment(horizontal: .leading, vertical: .center)
    public static let center: Alignment = Alignment(horizontal: .center, vertical: .center)
    public static let trailing: Alignment = Alignment(horizontal: .trailing, vertical: .center)
    public static let bottomLeading: Alignment = Alignment(horizontal: .leading, vertical: .bottom)
    public static let bottom: Alignment = Alignment(horizontal: .center, vertical: .bottom)
    public static let bottomTrailing: Alignment = Alignment(horizontal: .trailing, vertical: .bottom)
}
