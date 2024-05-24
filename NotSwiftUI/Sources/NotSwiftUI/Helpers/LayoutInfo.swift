import CoreGraphics

struct LayoutInfo: Comparable {

    let minWidth: CGFloat
    let maxWidth: CGFloat
    let idx: Int
    let priority: Double

    private var flexibility: CGFloat {
        maxWidth - minWidth
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.priority > rhs.priority { return true }
        if rhs.priority > lhs.priority { return false }
        return lhs.flexibility < rhs.flexibility
    }
}
