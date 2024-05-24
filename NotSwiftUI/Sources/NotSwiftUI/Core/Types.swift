import SwiftUI

#if os(macOS)
import AppKit

public typealias Color = NSColor
public typealias Font = NSFont
public typealias Image = NSImage
#elseif os(iOS)
import UIKit

public typealias Color = UIColor
public typealias Font = UIFont
public typealias Image = UIImage
#endif

public extension SwiftUI.Image {
    init(native: Image) {
        #if os(macOS)
        self.init(nsImage: native)
        #elseif os(iOS)
        self.init(uiImage: native)
        #endif
    }
}
