import NotSwiftUI
import SwiftUI

struct ContentView: SwiftUI.View {

    private let size = CGSize(width: 600, height: 400)

    @State private var opacity: Double = 0.5
    @State private var width: CGFloat = 300

    private var sample: some NotSwiftUI.View {
        NotSwiftUI.Ellipse()
            .overlay(
                NotSwiftUI.GeometryReader { size in
                    NotSwiftUI.Text("\(size.width) \(size.height)")
                }
                    .border(.white, width: 1)
            )
            .frame(width: width, height: 300, alignment: .topLeading)
    }


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
            
            Slider(value: $opacity, in: 0...1) {
                Text("Opacity \(opacity)")
            }
            Slider(value: $width, in: 0...600) {
                Text("Width \(width)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
