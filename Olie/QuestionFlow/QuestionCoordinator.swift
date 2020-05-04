import UIKit
import RxSwift

final class QuestionCoordinator {
    
    private let tag = BehaviorSubject<Tag?>(value: nil)
    private let slug = BehaviorSubject<String>(value: "")
    private let anwser = BehaviorSubject<String>(value: "")
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.barTintColor = .primaryLightest
    }
    
    func start() {
        let viewModel = QuestionViewModel(
            services: Services(),
            tag: tag,
            slug: slug,
            anwser: anwser
        )
        let viewController = QuestionViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.navigation
            .filter { $0 == .simulate }
            .subscribe(onNext: { [simulate] _ in
                simulate()
            })
            .disposed(by: viewController.disposeBag)
    }
    
    func simulate() {
        let viewModel = SimulateViewModel(
            services: Services(),
            tag: tag,
            slug: slug,
            anwser: anwser
        )
        let viewController = SimulateViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.navigation
        .filter { $0 == .confirmation }
        .subscribe(onNext: { [confirmation] _ in
            confirmation()
        })
        .disposed(by: viewController.disposeBag)
    }
    
    func confirmation() {
        let feedbackCoordinator = FeedbackCoordinator(navigationController: navigationController)
        feedbackCoordinator.start()
    }
}
