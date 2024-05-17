import NotSwiftUI
import SwiftUI

struct ContentView: SwiftUI.View {

    private let size = CGSize(width: 600, height: 400)

    @State private var opacity: Double = 0.5
    @State private var width: CGFloat = 300
    @State private var height: CGFloat = 300
    @State private var minWidth: (width: CGFloat, enabled: Bool) = (100, true)
    @State private var maxWidth: (width: CGFloat, enabled: Bool) = (500, false)
    @State private var minHeight: (height: CGFloat, enabled: Bool) = (100, true)
    @State private var maxHeight: (height: CGFloat, enabled: Bool) = (500, false)

    private var sample: some NotSwiftUI.View {
        NotSwiftUI.Ellipse()
            .foregroundColor(.blue)
            .frame(width: 150)
            .frame(
                minWidth: minWidth.enabled ? minWidth.width : nil,
                maxWidth: maxWidth.enabled ? maxWidth.width : nil,
                minHeight: minHeight.enabled ? minHeight.height : nil,
                maxHeight: maxHeight.enabled ? maxHeight.height : nil
            )
            .overlay(
                NotSwiftUI.GeometryReader { size in
                    NotSwiftUI.Text("\(size.width) \(size.height)")
                }
                    .border(.white, width: 1)
            )
            .frame(width: width, height: height)
            .border(.yellow, width: 2)
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

            VStack {
                Slider(value: $opacity, in: 0...1) {
                    Text("Opacity".withFormattedValue(opacity))
                }
                Slider(value: $width, in: 0...600) {
                    Text("Width".withFormattedValue(width))
                }
                Slider(value: $height, in: 0...400) {
                    Text("Height".withFormattedValue(height))
                }
                HStack {
                    Toggle("Min width enabled", isOn: $minWidth.enabled)
                        .labelsHidden()
                    Slider(value: $minWidth.width, in: 0...600) {
                        Text("Min width".withFormattedValue(minWidth.width))
                    }
                }
                HStack {
                    Toggle("Max width enabled", isOn: $maxWidth.enabled)
                        .labelsHidden()
                    Slider(value: $maxWidth.width, in: 0...600) {
                        Text("Max width".withFormattedValue(maxWidth.width))
                    }
                }
                HStack {
                    Toggle("Min height enabled", isOn: $minHeight.enabled)
                        .labelsHidden()
                    Slider(value: $minHeight.height, in: 0...400) {
                        Text("Min height".withFormattedValue(minHeight.height))
                    }
                }
                HStack {
                    Toggle("Max height enabled", isOn: $maxHeight.enabled)
                        .labelsHidden()
                    Slider(value: $maxHeight.height, in: 0...400) {
                        Text("Max height".withFormattedValue(maxHeight.height))
                    }
                }
            }
            .padding()
        }
    }
}

private extension String {

    func withFormattedValue(_ value: Double) -> String {
        String(format: "\(self) %.2f", value)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
