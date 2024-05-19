import SwiftUI

public struct Text: View, BuiltinView {

    let text: String

    public init(_ text: String) {
        self.text = text
    }

    private let font = NSFont.systemFont(ofSize: 16)

    private var attributes: [NSAttributedString.Key: Any] {
        [
            .font: font,
            .foregroundColor: NSColor.white
        ]
    }

    private var framesetter: CTFramesetter {
        let string = NSAttributedString(string: text, attributes: attributes)
        let frameSetter = CTFramesetterCreateWithAttributedString(string)
        return frameSetter
    }

    public func render(context: RenderingContext, size: CGSize) {
        let frame = CTFramesetterCreateFrame(
            framesetter,
            CFRange(),
            CGPath(rect: CGRect(origin: .zero, size: size), transform: nil),
            nil
        )

        context.saveGState()
        CTFrameDraw(frame, context)
        context.restoreGState()
    }

    public func customAlignment(for alignment: HorizontalAlignment, in size: CGSize) -> CGFloat? {
        nil
    }

    public func size(proposed: ProposedSize) -> CGSize {
        CTFramesetterSuggestFrameSizeWithConstraints(
            framesetter,
            CFRange(),
            nil,
            proposed.orMax,
            nil
        )
    }

    public var swiftUI: some SwiftUI.View {
        SwiftUI.Text(text).font(Font(font))
    }
}
