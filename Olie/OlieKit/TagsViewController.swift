import UIKit
import TagListView
import RxSwift
import RxCocoa

final class TagsViewController: UIViewController {
    
    let tagIndex = PublishSubject<Int>()
    
    let tag = PublishSubject<TagOptional>()
    
    let olieView5 = OlieView5()
    
    let scrollView = OlieScrollView()
    
    let button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "icon_close"), for: .normal)
        return $0
    }(UIButton())
    
    private let contentScrollView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private let tagListView: TagListView = {
        $0.marginX = .small
        $0.marginY = .small
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(TagListView())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupButton()
        setupOlieView5()
        setupScrollView()
        setupContentScrollView()
        setupTagListView()
    }
    
    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primaryLightest
        
        view.layer.shadowColor = UIColor.shadowCard.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        view.layer.shadowRadius = 16.0
    }
    
    private func setupButton() {
        view.addSubview(button)
        
        let guide = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalToConstant: 44),
            button.topAnchor.constraint(equalTo: guide.topAnchor, constant: .small),
            margins.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
    }
    
    private func setupOlieView5() {
        view.addSubview(olieView5)
        
        let guide = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            olieView5.topAnchor.constraint(equalTo: guide.topAnchor, constant: .largexx),
            olieView5.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: .small),
            margins.trailingAnchor.constraint(equalTo: olieView5.trailingAnchor, constant: .small)
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        let guide = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: olieView5.bottomAnchor, constant: .largexx),
            scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: .small),
            margins.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: .small),
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
    
    private func setupTagListView() {
        contentScrollView.addSubview(tagListView)
        
        tagListView.delegate = self
        
        NSLayoutConstraint.activate([
            tagListView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            tagListView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: tagListView.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: tagListView.bottomAnchor)
        ])
    }
    
    func addTags(tags: [Tag]) {
        
        for (index, item) in tags.enumerated() {
            let tag = tagListView.addTag(item.name)
            tag.tag = index
            
            tag.textFont = .button
            tag.borderWidth = .buttonBorderWidth
            tag.cornerRadius = .buttonTagCornerRadious
            
            tag.paddingX = .small
            tag.paddingY = .medium
            
            tag.borderColor = item.color
            tag.textColor = item.color
            tag.backgroundColor = .primaryLightest
        }
    }
}

extension TagsViewController: TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) -> Void {
        tagIndex.onNext(tagView.tag)
        tag.onNext(TagOptional(color: tagView.titleLabel?.textColor, name: tagView.currentTitle))
    }
}

