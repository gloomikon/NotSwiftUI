import NotSwiftUI
import SwiftUI

var sample: some NotSwiftUI.View {
    NotSwiftUI.Ellipse()
        .frame(width: 200, height: 100)
}

struct ContentView: SwiftUI.View {
    
    private let size = CGSize(width: 600, height: 400)
    
    @State private var opacity: Double = 0.5
    
    var body: some SwiftUI.View {
        VStack {

            ZStack {
                Image(
                    nsImage: NSImage(data: NotSwiftUI.render(view: sample, size: size))!
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(1 - opacity)
                
                sample.swiftUI
                    .frame(width: size.width, height: size.height)
                    .opacity(opacity)
            }
            
            Slider(value: $opacity, in: 0...1)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
