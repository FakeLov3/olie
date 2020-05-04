import UIKit

final class OlieView6: UIView {
    
    let label: OlieLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.apply(style: .style3)
        return $0
    }(OlieLabel())
    
    let textView: UITextView = {
        $0.textContainerInset = UIEdgeInsets(top: .medium, left: .medium, bottom: .medium, right: .medium)
        $0.font = .subhead
        $0.layer.cornerRadius = 8.0
        $0.layer.borderWidth = 2.0
        $0.layer.borderColor = UIColor.secondaryDark.cgColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextView())
    
    let bottomView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .secondaryDark
        $0.layer.cornerRadius = 8.0
        return $0
    }(UIView())
    
    let bottomLabel: OlieLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.apply(style: .style7)
        return $0
    }(OlieLabel())
    
    let bottomImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "icon_question")
        return $0
    }(UIImageView())
    
    init() {
        super.init(frame: CGRect())
        
        setupView()
        setupLabe()
        setupTextView()
        setupBottomView()
        setupBottomLabel()
        setupBottomImageView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    private func setupLabe() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: label.trailingAnchor)
        ])
    }
    
    private func setupTextView() {
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: .medium),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 96.0)
        ])
    }
    
    private func setupBottomView() {
        addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: .medium),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }
    
    private func setupBottomLabel() {
        bottomView.addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: .medium),
            bottomLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 56.0),
            bottomView.trailingAnchor.constraint(equalTo:  bottomLabel.trailingAnchor, constant: .medium),
            bottomView.bottomAnchor.constraint(equalTo:  bottomLabel.bottomAnchor, constant: .medium)
        ])
    }
    
    private func setupBottomImageView() {
        bottomView.addSubview(bottomImageView)
        
        NSLayoutConstraint.activate([
            bottomLabel.leadingAnchor.constraint(equalTo: bottomImageView.trailingAnchor, constant: .medium),
            bottomImageView.centerYAnchor.constraint(equalTo: bottomLabel.centerYAnchor)
        ])
    }
}
