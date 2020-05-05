import RxSwift
import RxCocoa
import RxSwiftExt

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
        refreshButtonTap: Observable<Void>,
        bottomButtonTap: Observable<Void>
    ) -> (
        question: Driver<String>,
        loadingQuestion: Driver<Bool>,
        loadingAwnser: Driver<Bool>,
        bottomButtonTitle: Driver<String>
        ) {
            
            let questionsTracker = ActivityIndicator()
            
            let questionsFromFirstRequest = slug
                .flatMapLatest { [getQuestions, questionsTracker] in getQuestions($0, questionsTracker) }
            
            let questionsFromRefresh = refreshButtonTap
                .withLatestFrom(slug)
                .flatMapLatest { [getQuestions, questionsTracker] in getQuestions($0, questionsTracker) }
            
            let question = Observable.merge(questionsFromFirstRequest, questionsFromRefresh)
                .map { $0.sample_questions }
                .map { $0.first }
                .unwrap()
                .asDriver(onErrorJustReturn: "")
            
            let awnserParameters = Observable.combineLatest(anwser.asObserver(), slug.asObserver())
                .map { Answer(text: $0.0, tag: $0.1) }
            
            let awnserTracker = ActivityIndicator()
            
            let bottomButtonTitle1 = awnserTracker
                .asObservable()
                .filter { $0 }
                .map { _ in "" }
                
            
            let bottomButtonTitle2 = awnserTracker
                .asObservable()
                .filter { !$0 }
                .map { _ in "Confirmar resposta" }
                
            
            let bottomButtonTitle = Observable.merge(bottomButtonTitle1, bottomButtonTitle2)
                .asDriver(onErrorJustReturn: "")
            
            bottomButtonTap
                .withLatestFrom(awnserParameters)
                .flatMapLatest { [postAwnser, awnserTracker] in postAwnser($0, awnserTracker) }
                .map { _ in .confirmation }
                .bind(to: navigationPublisher)
                .disposed(by: disposeBag)
            
            return (
                question: question,
                loadingQuestion: questionsTracker.asDriver(onErrorJustReturn: false),
                loadingAwnser: awnserTracker.asDriver(onErrorJustReturn: false),
                bottomButtonTitle: bottomButtonTitle
            )
    }
    
    func getQuestions(slug: String, tracker: ActivityIndicator) -> Observable<Questions> {
        return services.questions(slug: slug)
            .asObservable()
            .trackActivity(tracker)
            .catchError { error -> Observable<Questions> in return .empty() }
    }
    
    func postAwnser(_ awnser: Answer, tracker: ActivityIndicator) -> Observable<Void> {
        return services.answer(awnser)
            .asObservable()
            .trackActivity(tracker)
            .catchError { error -> Observable<Void> in return .empty() }
    }
}
