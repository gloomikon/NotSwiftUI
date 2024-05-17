import AppKit
import SwiftUI

extension NSColor: View {
    
    public var body: some View {
        ShapeView(shape: Rectangle()).foregroundColor(self)
    }
    
    public var swiftUI: some SwiftUI.View {
        Color(self)
    }
}
