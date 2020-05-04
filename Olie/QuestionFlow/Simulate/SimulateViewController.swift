import UIKit
import RxSwift
import RxCocoa

final class SimulateViewController: UIViewController {
    
    let scrollView = OlieScrollView()
    
    private let contentScrollView: UIView = {
        $0.clipsToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    let olieView7 = OlieView7()
    
    let olieView6 = OlieView6()
    
    let bottomButton: OlieButton = {
        $0.apply(style: .primary)
        return $0
    }(OlieButton())
    
    let disposeBag = DisposeBag()
    
    private let viewModel: SimulateViewModel
    
    init(viewModel: SimulateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        setupView()
        setupScrollView()
        setupContentScrollView()
        setupOlieView7()
        setupOlieView6()
        setupBottomButton()
        
        let staticOutput =  viewModel.staticInput()
        
        staticOutput.text1
            .drive(olieView7.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text2
            .drive(olieView7.subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text3
            .drive(olieView6.label.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.awnser
            .drive(olieView6.textView.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text4
            .drive(olieView6.bottomLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.tag
            .unwrap()
            .drive(onNext: { [setupTag] in setupTag($0) })
            .disposed(by: disposeBag)
        
        staticOutput.bottomButtonTitle
            .drive(bottomButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.dynamicInput(bottomButtonTap: bottomButton.rx.tap.asObservable())
    }
    
    private func setupView() {
        view.backgroundColor = .primaryLightest
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        let guide = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            margins.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            guide.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1.0)
        ])
    }
    
    private func setupContentScrollView() {
        scrollView.addSubview(contentScrollView)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            margins.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
        ])
    }
    
    private func setupOlieView7() {
        contentScrollView.addSubview(olieView7)
        
        NSLayoutConstraint.activate([
            olieView7.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: .medium),
            olieView7.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: olieView7.trailingAnchor),
        ])
    }
    
    private func setupOlieView6() {
        contentScrollView.addSubview(olieView6)
        
        NSLayoutConstraint.activate([
            olieView6.topAnchor.constraint(equalTo: olieView7.bottomAnchor, constant: .large),
            olieView6.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: olieView6.trailingAnchor)
        ])
    }
    
    private func setupBottomButton() {
        contentScrollView.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            bottomButton.topAnchor.constraint(greaterThanOrEqualTo: olieView6.bottomAnchor, constant: .large),
            bottomButton.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomButton.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }
    
    private func setupTag(_ tag: Tag) {
        olieView7.tagButton.layer.borderColor = tag.color.cgColor
        olieView7.tagButton.setTitleColor(tag.color, for: .normal)
        olieView7.tagButton.setTitle(tag.name, for: .normal)
    }
}
