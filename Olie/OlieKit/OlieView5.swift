import UIKit

final class OlieView5: UIView {
    
    let titleLabel: OlieLabel = {
        $0.apply(style: .style5)
        $0.textAlignment = .left
        return $0
    }(OlieLabel())
    
    let subtitleLabel: OlieLabel = {
        $0.apply(style: .style6)
        $0.textAlignment = .left
        return $0
    }(OlieLabel())
    
    init() {
        super.init(frame: CGRect())
        setupView()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .small),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor)
        ])
    }
}
