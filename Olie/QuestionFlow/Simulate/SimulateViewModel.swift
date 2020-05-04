import RxSwift
import RxCocoa

final class SimulateViewModel {
    
    enum Destination {
        case confirmation
    }
    
    private let navigationPublisher = PublishSubject<Destination>()
    private let disposeBag = DisposeBag()
    
    var navigation: Observable<Destination> {
        navigationPublisher.asObservable()
    }
    
    private let services: ServicesProtocol
    private let tag: BehaviorSubject<Tag?>
    private let slug: BehaviorSubject<String>
    private let anwser: BehaviorSubject<String>
    
    init(
        services: ServicesProtocol,
        tag: BehaviorSubject<Tag?>,
        slug: BehaviorSubject<String>,
        anwser: BehaviorSubject<String>
    ) {
        self.services = services
        self.tag = tag
        self.slug = slug
        self.anwser = anwser
    }
    
    func staticInput() -> (
        text1: Driver<String>,
        text2: Driver<String>,
        text3: Driver<String>,
        text4: Driver<String>,
        bottomButtonTitle: Driver<String>,
        awnser: Driver<String>,
        tag: Driver<Tag?>
        ) {
            
            return (
                text1: .just("Olie"),
                text2: .just("Porto Alegre, RS"),
                text3: .just("Resposta Simulada"),
                text4: .just("Caso queira alterar o texto para essa pergunta, edite sua resposta."),
                bottomButtonTitle: .just("Confirmar resposta"),
                awnser: anwser.asDriver(onErrorJustReturn: ""),
                tag: tag.asDriver(onErrorJustReturn: nil)
            )
    }
    
    func dynamicInput(
        bottomButtonTap: Observable<Void>
    ) {
        bottomButtonTap
            .map { _ in .confirmation }
            .bind(to: navigationPublisher)
            .disposed(by: disposeBag)
    }
}
