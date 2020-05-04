import UIKit
import RxSwift
import RxCocoa

final class QuestionViewController: UIViewController {
    
    let scrollView = OlieScrollView()
    
    private let contentScrollView: UIView = {
        $0.clipsToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    let olieView3 = OlieView3()
    
    let olieView4 = OlieView4()
    
    let olieView6: OlieView6 = {
        $0.isHidden = true
        return $0
    }(OlieView6())
    
    let bottomButton: OlieButton = {
        $0.isHidden = true
        $0.apply(style: .primary)
        return $0
    }(OlieButton())

    let disposeBag = DisposeBag()
    
    private let tagsViewController = TagsViewController()

    private let viewModel: QuestionViewModel
    
    init(viewModel: QuestionViewModel) {
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
        setupOlieView3()
        setupOlieView4()
        setupOlieView5()
        setupBottomButton()
        
        setupTagsViewController()
        
        olieView3.button.rx.tap
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [showTagsViewController] _ in showTagsViewController() })
            .disposed(by: disposeBag)
        
        tagsViewController.button.rx.tap
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [hideTagsViewController] _ in hideTagsViewController() })
            .disposed(by: disposeBag)
        
        let staticOutput = viewModel.staticInput()
        
        staticOutput.text1
            .drive(olieView3.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text2
            .drive(olieView3.subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text3
            .drive(tagsViewController.olieView5.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text4
            .drive(tagsViewController.olieView5.subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.buttonTitle
            .drive(olieView3.button.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        staticOutput.text5
            .drive(olieView6.label.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text6
            .drive(olieView6.textView.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text7
            .drive(olieView6.bottomLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.bottomButtonTitle
            .drive(bottomButton.rx.title())
            .disposed(by: disposeBag)
        
        let dynamicOutput = viewModel.dynamicInput(
            text: olieView6.textView.rx.text.asObservable(),
            tagIndex: tagsViewController.tagIndex.asObserver(),
            tag: tagsViewController.tag.asObserver(),
            bottomButtonTap: bottomButton.rx.tap.asObservable()
        )
        
        dynamicOutput.tags
            .drive()
            .disposed(by: disposeBag)
        
        dynamicOutput.tags
            .drive(onNext: { [tagsViewController] in tagsViewController.addTags(tags: $0) })
            .disposed(by: disposeBag)
        
        dynamicOutput.shouldShowTagLoader
            .drive(olieView3.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        dynamicOutput.shouldShowTagLoader
            .drive(olieView3.button.rx.isHidden)
            .disposed(by: disposeBag)
        
        dynamicOutput.question1
            .drive(olieView4.label1.rx.text)
            .disposed(by: disposeBag)
        
        dynamicOutput.question2
            .drive(olieView4.label2.rx.text)
            .disposed(by: disposeBag)
        
        dynamicOutput.question3
            .drive(olieView4.label3.rx.text)
            .disposed(by: disposeBag)
        
        dynamicOutput.shouldShowQuestionsLoader
            .drive(olieView4.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        dynamicOutput.shouldShowQuestionsLoader
            .filter { $0 }
            .drive(onNext: { [olieView4] _ in olieView4.hideViews() })
            .disposed(by: disposeBag)
        
        dynamicOutput.shouldShowQuestionsLoader
            .filter { !$0 }
            .skip(1)
            .drive(onNext: { [olieView4] _ in olieView4.showViews() })
            .disposed(by: disposeBag)
        
        dynamicOutput.shouldShowQuestionsLoader
            .filter { !$0 }
            .skip(1)
            .drive(olieView6.rx.isHidden)
            .disposed(by: disposeBag)
        
        dynamicOutput.shouldShowQuestionsLoader
            .filter { !$0 }
            .skip(1)
            .drive(bottomButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        dynamicOutput.hideTagView
            .drive(onNext: { [hideTagsViewController] _ in hideTagsViewController() })
            .disposed(by: disposeBag)
        
        dynamicOutput.tagName
            .drive(olieView3.button.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        dynamicOutput.tagColor
            .drive(onNext: { [updateColors] in 
                updateColors($0)
            })
            .disposed(by: disposeBag)
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
    
    private func setupOlieView3() {
        contentScrollView.addSubview(olieView3)
        
        NSLayoutConstraint.activate([
            olieView3.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            olieView3.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: olieView3.trailingAnchor)
        ])
    }
    
    private func setupOlieView4() {
        contentScrollView.addSubview(olieView4)
        
        NSLayoutConstraint.activate([
            olieView4.topAnchor.constraint(equalTo: olieView3.bottomAnchor, constant: .mediumx),
            olieView4.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: olieView4.trailingAnchor),
        ])
    }
    
    private func setupOlieView5() {
        contentScrollView.addSubview(olieView6)
        
        NSLayoutConstraint.activate([
            olieView6.topAnchor.constraint(equalTo: olieView4.bottomAnchor, constant: .large),
            olieView6.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: olieView6.trailingAnchor),
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
    
    private func setupTagsViewController() {
        view.addSubview(tagsViewController.view)
        addChild(tagsViewController)
        tagsViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            tagsViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            tagsViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tagsViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tagsViewController.view.bottomAnchor)
        ])
        
        tagsViewController.view.transform = CGAffineTransform(translationX: 0.0, y: tagsViewController.view.bounds.height)
    }

    private func hideTagsViewController() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.tagsViewController.view.transform = CGAffineTransform(translationX: 0.0, y: self.tagsViewController.view.bounds.height)
        }, completion: nil)
    }
    
    private func showTagsViewController() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.tagsViewController.view.transform = .identity
        }, completion: nil)
    }
    
    private func updateColors(color: UIColor) {
        olieView4.verticalView.backgroundColor = color
        olieView3.button.layer.borderColor = color.cgColor
        olieView3.button.setTitleColor(color, for: .normal)
    }
}

