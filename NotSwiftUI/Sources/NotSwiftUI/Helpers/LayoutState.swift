@propertyWrapper
final class LayoutState<A> {

    var wrappedValue: A

    init(wrappedValue: A) {
        self.wrappedValue = wrappedValue
    }
}
