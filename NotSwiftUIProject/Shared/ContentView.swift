import NotSwiftUI
import SwiftUI

private enum MyLeadingAlignment: NotSwiftUI.AlignmentID, SwiftUI.AlignmentID {

    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        .zero
    }

    static func defaultValue(in context: CGSize) -> CGFloat {
        .zero
    }
}

private extension NotSwiftUI.HorizontalAlignment {
    static let myLeading = Self(
        MyLeadingAlignment.self,
        swiftUI: HorizontalAlignment(MyLeadingAlignment.self)
    )
}

private extension NotSwiftUI.View {
    var measured: some NotSwiftUI.View {
        overlay(NotSwiftUI.GeometryReader { size in
            NotSwiftUI.Text("\(size.width) \(size.height)")
        })
    }
}

struct ContentView: SwiftUI.View {

    private let size = CGSize(width: 600, height: 400)

    @State private var opacity: Double = 0.5
    @State private var width: CGFloat = 300

    private var sample: some NotSwiftUI.View {
        NotSwiftUI.VGrid(
            columns: [100, 200],
            content: [
                NotSwiftUI.AnyView(
                    NotSwiftUI.Rectangle()
                        .foregroundColor(.red)
                        .measured
                ),
                NotSwiftUI.AnyView(
                    NotSwiftUI.Rectangle()
                        .foregroundColor(.green)
                        .frame(minWidth: 74, minHeight: 50)
                        .measured
                ),
                NotSwiftUI.AnyView(
                    NotSwiftUI.Rectangle()
                        .foregroundColor(.yellow)
                        .frame(maxWidth: 23, minHeight: 75)
                        .measured
                )
            ]
        )
        .border(.white)
        .frame(width: width, height: 200)
        .border(.red)
    }

    var body: some SwiftUI.View {
        VStack {
            ZStack {
                Image(native: NotSwiftUI.Image(data: NotSwiftUI.render(view: sample, size: size))!
                )
                .resizable()
                .frame(width: size.width, height: size.height)
                .opacity(1 - opacity)
                
                sample.swiftUI
                    .frame(width: size.width, height: size.height)
                    .opacity(opacity)
            }

            VStack {
                Slider(value: $opacity, in: 0...1) {
                    Text("Opacity".withFormattedValue(opacity))
                }

                Slider(value: $width, in: 0...400) {
                    Text("Width".withFormattedValue(width))
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
