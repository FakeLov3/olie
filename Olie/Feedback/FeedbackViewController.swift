import UIKit
import RxSwift
import RxCocoa
import TagListView

final class FeedbackViewController: UIViewController {
    
    let scrollView = OlieScrollView()
    
    private let contentScrollView: UIView = {
        $0.clipsToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let olieView1 = OlieView1()
    
    private let olieView2 = OlieView2()
    
    private let tagListView: TagListView = {
        $0.marginX = .medium
        $0.marginY = .medium
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(TagListView())
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: FeedbackViewModel
    
    init(viewModel: FeedbackViewModel) {
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
        setupImageView()
        setupOlieView1()
        setupOlieView2()
        setupTagListView()
        
        let staticOutput = viewModel.staticInput()
        
        staticOutput.image
            .drive(imageView.rx.image)
            .disposed(by: disposeBag)
        
        staticOutput.text1
            .drive(olieView1.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text2
            .drive(olieView1.subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text3
            .drive(olieView2.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        staticOutput.text4
            .drive(olieView2.subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        let dynamicOuput = viewModel.dynamicInput()
        
        dynamicOuput.tags
            .drive(onNext: { [addTags] in addTags($0) })
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
    
    func setupImageView() {
        contentScrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 160.0),
            imageView.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: .largexxx),
            imageView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
    
    private func setupOlieView1() {
        contentScrollView.addSubview(olieView1)
        
        NSLayoutConstraint.activate([
            olieView1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .large),
            olieView1.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: olieView1.trailingAnchor),
        ])
    }
    
    private func setupOlieView2() {
        contentScrollView.addSubview(olieView2)
        
        NSLayoutConstraint.activate([
            olieView2.topAnchor.constraint(equalTo: olieView1.bottomAnchor, constant: .largexx),
            olieView2.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: olieView2.trailingAnchor)
        ])
    }
    
    private func setupTagListView() {
        contentScrollView.addSubview(tagListView)
        
        NSLayoutConstraint.activate([
            tagListView.topAnchor.constraint(equalTo: olieView2.bottomAnchor, constant: .medium),
            tagListView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: tagListView.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: tagListView.bottomAnchor)
        ])
    }
    
    private func addTags(tags: [Tag]) {
        tags.forEach {
            let tag = tagListView.addTag($0.name)
            tag.textFont = .button
            tag.borderWidth = .buttonBorderWidth
            tag.cornerRadius = .buttonTagCornerRadious
            
            tag.paddingX = .small
            tag.paddingY = .small
            
            tag.borderColor = $0.color
            tag.textColor = $0.color
            tag.backgroundColor = .primaryLightest
        }
    }
}
