import UIKit

final class OlieView7: UIView {
    
    let activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.startAnimating()
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))
    
    let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "icon_profile")
        return $0
    }(UIImageView())
    
    let tagButton: OlieButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentEdgeInsets = UIEdgeInsets(top: .small, left: .medium, bottom: .small, right: .medium)
        $0.apply(style: .tag)
        return $0
    }(OlieButton())
    
    let refreshButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "icon_refresh"), for: .normal)
        return $0
    }(UIButton())
    
    let titleLabel: OlieLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.apply(style: .style1)
        return $0
    }(OlieLabel())
    
    let subtitleLabel: OlieLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.apply(style: .style4)
        return $0
    }(OlieLabel())
    
    let messageLabel: OlieLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.apply(style: .style2)
        return $0
    }(OlieLabel())
    
    let bottomView: UIView = {
        $0.backgroundColor = .secondaryDark
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    init() {
        super.init(frame: CGRect())
        
        setupView()
        setupImageView()
        setupTag()
        setupTitleLabel()
        setupSubtitleLabel()
        setupRefreshButton()
        setupMessageLabel()
        setupBottomView()
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
    
    private func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 52.0),
            imageView.widthAnchor.constraint(equalToConstant: 52.0)
        ])
    }
    
    private func setupTag() {
        addSubview(tagButton)
        
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: tagButton.trailingAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .large),
            tagButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: .large)
        ])
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .small),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .large),
            tagButton.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: .large)
        ])
    }
    
    private func setupRefreshButton() {
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: tagButton.bottomAnchor, constant: .large),
            trailingAnchor.constraint(equalTo: refreshButton.trailingAnchor)
        ])
    }
    
    private func setupMessageLabel() {
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: .large),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: refreshButton.leadingAnchor, constant: .large)
        ])
    }
    
    private func setupBottomView() {
        addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: .large),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: messageLabel.centerXAnchor)
        ])
    }
}
