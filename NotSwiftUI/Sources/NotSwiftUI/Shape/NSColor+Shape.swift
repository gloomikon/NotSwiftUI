import CoreGraphics
import SwiftUI

extension Color: View {
    
    public var body: some View {
        ShapeView(shape: Rectangle()).foregroundColor(self)
    }
    
    public var swiftUI: some SwiftUI.View {
        SwiftUI.Color(self)
    }
}
