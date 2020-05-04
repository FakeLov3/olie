import UIKit

final class OlieView4: UIView {
    
    let activityIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.startAnimating()
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))
    
    let verticalView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    let imageView1: UIImageView = {
        $0.image = UIImage(named: "icon_chat")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let label1: OlieLabel = {
        $0.apply(style: .style6)
        return $0
    }(OlieLabel())
    
    let imageView2: UIImageView = {
        $0.image = UIImage(named: "icon_chat")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let label2: OlieLabel = {
        $0.apply(style: .style6)
        return $0
    }(OlieLabel())
    
    let imageView3: UIImageView = {
        $0.image = UIImage(named: "icon_chat")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let label3: OlieLabel = {
        $0.apply(style: .style6)
        return $0
    }(OlieLabel())
    
    init() {
        super.init(frame: CGRect())
        
        setupView()
        setupVerticalView()
        setupLabel1()
        setupLabel2()
        setupLabel3()
        setupImage1()
        setupImage2()
        setupImage3()
        setupActivityIndicator()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        hideViews()
    }
    
    private func setupVerticalView() {
        addSubview(verticalView)
        
        NSLayoutConstraint.activate([
            verticalView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: verticalView.bottomAnchor),
            verticalView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalView.widthAnchor.constraint(equalToConstant: 2.0)
        ])
    }
    
    private func setupLabel1() {
        addSubview(label1)
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: topAnchor, constant: .small),
            label1.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor, constant: .largexx),
            trailingAnchor.constraint(equalTo: label1.trailingAnchor)
        ])
    }
    
    private func setupLabel2() {
        addSubview(label2)
        
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: .small),
            label2.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor, constant: .largexx),
            trailingAnchor.constraint(equalTo: label2.trailingAnchor)
        ])
    }
    
    private func setupLabel3() {
        addSubview(label3)
        
        NSLayoutConstraint.activate([
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: .small),
            label3.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor, constant: .largexx),
            trailingAnchor.constraint(equalTo: label3.trailingAnchor),
            bottomAnchor.constraint(equalTo: label3.bottomAnchor, constant: .small)
        ])
    }
    
    private func setupImage1() {
        addSubview(imageView1)
        
        NSLayoutConstraint.activate([
            
            label1.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor, constant: .small),
            imageView1.centerYAnchor.constraint(equalTo: label1.centerYAnchor, constant: 2.0)
        ])
    }

    private func setupImage2() {
        addSubview(imageView2)
        
        NSLayoutConstraint.activate([
            label2.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor, constant: .small),
            imageView2.centerYAnchor.constraint(equalTo: label2.centerYAnchor, constant: 2.0)
        ])
    }
    
    private func setupImage3() {
        addSubview(imageView3)
        
        NSLayoutConstraint.activate([
            label3.leadingAnchor.constraint(equalTo: imageView3.trailingAnchor, constant: .small),
            imageView3.centerYAnchor.constraint(equalTo: label3.centerYAnchor, constant: 2.0)
        ])
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func hideViews() {
        verticalView.isHidden = true
        imageView1.isHidden = true
        label1.isHidden = true
        imageView2.isHidden = true
        label2.isHidden = true
        imageView3.isHidden = true
        label3.isHidden = true
    }
    
    func showViews() {
        verticalView.isHidden = false
        imageView1.isHidden = false
        label1.isHidden = false
        imageView2.isHidden = false
        label2.isHidden = false
        imageView3.isHidden = false
        label3.isHidden = false
    }
}
