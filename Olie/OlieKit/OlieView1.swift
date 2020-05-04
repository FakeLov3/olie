import UIKit

final class OlieView1: UIView {
    
    let titleLabel: OlieLabel = {
        $0.apply(style: .style1)
        $0.textAlignment = .center
        return $0
    }(OlieLabel())
    
    let subtitleLabel: OlieLabel = {
        $0.apply(style: .style2)
        $0.textAlignment = .center
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
        
        backgroundColor = .primaryLightest
        
        layer.shadowColor = UIColor.shadowCard.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 16.0
        
        layer.cornerRadius = 8.0
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .large),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .medium),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: .medium)
        ])
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .small),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .medium),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: .medium),
            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: .large)
        ])
    }
}
