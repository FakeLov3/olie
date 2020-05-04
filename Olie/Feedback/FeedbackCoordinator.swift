import UIKit

final class FeedbackCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FeedbackViewModel(services: Services())
        let viewController = FeedbackViewController(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }
}
