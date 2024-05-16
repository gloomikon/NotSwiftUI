import AppKit
import SwiftUI

extension NSColor: View {
    
    public var body: some View {
        ShapeView(shape: Rectangle(), color: self)
    }
    
    public var swiftUI: some SwiftUI.View {
        Color(self)
    }
}
