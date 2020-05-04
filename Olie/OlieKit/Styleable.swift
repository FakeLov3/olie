public protocol Styleable {
    associatedtype Style
    func apply(style: Style)
}
