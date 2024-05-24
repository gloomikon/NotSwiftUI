#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

extension CGContext {

    static func pdf(size: CGSize, render: (CGContext) -> ()) -> Data {
        let pdfData = NSMutableData()
        let consumer = CGDataConsumer(data: pdfData)!
        var mediaBox = CGRect(origin: .zero, size: size)
        let pdfContext = CGContext(consumer: consumer, mediaBox: &mediaBox, nil)!
        pdfContext.beginPage(mediaBox: &mediaBox)
        render(pdfContext)
        pdfContext.endPage()
        pdfContext.closePDF()
        return pdfData as Data
    }

    static func image(size: CGSize, render: (CGContext) -> ()) -> Data {
        #if os(macOS)
        pdf(size: size, render: render)
        #elseif os(iOS)
        UIGraphicsImageRenderer(size: size).pngData { context in
            render(context.cgContext)
        }
        #endif
    }
}
