import UIKit

final class OlieLabel: UILabel {
    
    init() {
        super.init(frame: CGRect())
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

public struct OlieLabelStyle {
    let color: UIColor
    let font: UIFont
    
    static var style1: OlieLabelStyle {
        return OlieLabelStyle(
            color: .primary,
            font: .title2
        )
    }
    
    static var style2: OlieLabelStyle {
        return OlieLabelStyle(
            color: .primary,
            font: .body
        )
    }
    
    static var style3: OlieLabelStyle {
        return OlieLabelStyle(
            color: .primary,
            font: .headline
        )
    }
    
    static var style4: OlieLabelStyle {
        return OlieLabelStyle(
            color: .primary,
            font: .subhead
        )
    }
    
    static var style5: OlieLabelStyle {
        return OlieLabelStyle(
            color: .primary,
            font: .largeTitle
        )
    }
    
    static var style6: OlieLabelStyle {
        return OlieLabelStyle(
            color: .primaryLight,
            font: .body
        )
    }
    
    static var style7: OlieLabelStyle {
        return OlieLabelStyle(
            color: .primaryLight,
            font: .caption
        )
    }
}

extension OlieLabel: Styleable {
    
    public func apply(style: OlieLabelStyle) {
        textColor = style.color
        font = style.font
    }
}
