import NotSwiftUI
import SwiftUI

let sample = NSColor.blue

struct ContentView: SwiftUI.View {
    var body: some SwiftUI.View {
        Image(
            nsImage: NSImage(data: NotSwiftUI.render(view: sample))!
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
