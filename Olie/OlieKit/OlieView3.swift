import UIKit

final class OlieView3: UIView {
    
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
    
    let button: OlieButton = {
        $0.isHidden = true
        $0.contentEdgeInsets = UIEdgeInsets(top: .small, left: .medium, bottom: .small, right: .medium)
        $0.apply(style: .tag)
        return $0
    }(OlieButton())
    
    let activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.startAnimating()
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))
    
    init() {
        super.init(frame: CGRect())
        setupView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupButton()
        setupActivityIndicator()
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
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor)
        ])
    }
    
    private func setupButton() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: .small),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: button.trailingAnchor),
            bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
}
