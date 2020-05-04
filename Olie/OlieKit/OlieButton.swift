import UIKit

final class OlieButton: UIButton {
    
    init() {
        super.init(frame: CGRect())
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

public struct OlieButtonStyle {
    let borderColor: UIColor
    let borderWidth: CGFloat
    let cornerRadious: CGFloat
    let backgroundColor: UIColor
    let font: UIFont
    let fontColor: UIColor
    
    static var tag: OlieButtonStyle {
        return OlieButtonStyle(
            borderColor: .buttonPrimary,
            borderWidth: .buttonBorderWidth,
            cornerRadious: .buttonTagCornerRadious,
            backgroundColor: .primaryLightest,
            font: .button,
            fontColor: .buttonPrimary
        )
    }
    
    static var primary: OlieButtonStyle {
        return OlieButtonStyle(
            borderColor: .buttonPrimary,
            borderWidth: .buttonBorderWidth,
            cornerRadious: .buttonPrimaryCornerRadious,
            backgroundColor: .buttonPrimary,
            font: .button,
            fontColor: .primaryLightest
        )
    }
}

extension OlieButton: Styleable {
    public func apply(style: OlieButtonStyle) {
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadious
        backgroundColor = style.backgroundColor
        titleLabel?.font = style.font
        setTitleColor(style.fontColor, for: .normal)
    }
}
