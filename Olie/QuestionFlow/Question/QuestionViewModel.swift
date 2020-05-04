import RxSwift
import RxCocoa
import RxSwiftExt
import UIKit.UIColor

final class QuestionViewModel {
    
    enum Destination {
        case simulate
    }
    
    private let navigationPublisher = PublishSubject<Destination>()
    private let disposeBag = DisposeBag()
    
    var navigation: Observable<Destination> {
        navigationPublisher.asObservable()
    }
    
    var tags = [ModelClass]()
    
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
        buttonTitle: Driver<String>,
        text5: Driver<String>,
        text6: Driver<String>,
        text7: Driver<String>,
        bottomButtonTitle: Driver<String>
        ) {
            return (
                text1: .just("Perguntas"),
                text2: .just("Recebemos muitas perguntas relacionadas ao mesmo assunto, que tal deixar uma genérica para elas?"),
                text3: .just("Categorias"),
                text4: .just("Seleciona a categoria que deseja responder as dúvidas."),
                buttonTitle: .just("Categoria"),
                text5: .just("Digite sua resposta"),
                text6: .just("Ex. Olá, Fulano! Obrigado pela sua pergunta. Este produto está disponível nas cores XX, XX, XX. Vamos aguardar sua compra. Qualquer outra dúvida, estamos à disposição. Obrigado!"),
                text7: .just("Responda as perguntas de forma genérica, clara, detalhada e objetiva para ajudar o cliente a entender os benefícios do produto."),
                bottomButtonTitle: .just("Simular resposta")
            )
    }
    
    func dynamicInput(
        text: Observable<String?>,
        tagIndex: Observable<Int>,
        tag: Observable<TagOptional>,
        bottomButtonTap: Observable<Void>
    ) -> (
        tags: Driver<[Tag]>,
        shouldShowTagLoader: Driver<Bool>,
        question1: Driver<String>,
        question2: Driver<String>,
        question3: Driver<String>,
        shouldShowQuestionsLoader: Driver<Bool>,
        hideTagView: Driver<Void>,
        tagName: Driver<String>,
        tagColor: Driver<UIColor>
        ) {
            
            bottomButtonTap
                .map { _ in .simulate }
                .bind(to: navigationPublisher)
                .disposed(by: disposeBag)
            
            let tagTracker = ActivityIndicator()
            
            let tags = getModelClasses(tagTracker)
                .do(onNext: { [weak self] in self?.tags = $0 })
                .map { $0.map { Tag(color: $0.color, name: $0.name) } }
                .asDriver(onErrorJustReturn: [])
            
            let questionsTracker = ActivityIndicator()
            
            let slug = tagIndex
                .flatMapLatest { [weak self] in Observable.just(self?.tags[$0]) }
                .unwrap()
                .map { $0.slug }
            
            let questions = slug
                .flatMapLatest { [getQuestions, questionsTracker] in getQuestions($0, questionsTracker)}
                .map { $0.sample_questions }
                .filter { $0.count == 3 }
            
            let hideTagView = tagIndex
                .map { _ in Void() }
                .asDriver(onErrorJustReturn: ())
            
            let question1 = questions
                .map { $0[0] }
                .asDriver(onErrorJustReturn: "")
            
            let question2 = questions
                .map { $0[1] }
                .asDriver(onErrorJustReturn: "")
            
            let question3 = questions
                .map { $0[2] }
                .asDriver(onErrorJustReturn: "")
            
            let tagName = tag
                .map { $0.name }
                .unwrap()
                .asDriver(onErrorJustReturn: "")
            
            let tagColor = tag
                .map { $0.color }
                .unwrap()
                .asDriver(onErrorJustReturn: .clear)
            
            bottomButtonTap
                .withLatestFrom(slug)
                .bind(to: self.slug)
                .disposed(by: disposeBag)
            
            bottomButtonTap
                .withLatestFrom(text)
                .unwrap()
                .bind(to: self.anwser)
                .disposed(by: disposeBag)
            
            let name = tag
                .map { $0.name }
                .unwrap()
            
            let color = tag
                .map { $0.color }
                .unwrap()
               
            let tagUnwrapped = Observable.combineLatest(name, color)
                .map { Tag(color: $0.1, name: $0.0) }
            
            bottomButtonTap
                .withLatestFrom(tagUnwrapped)
                .bind(to: self.tag)
                .disposed(by: disposeBag)
            
            return (
                tags: tags,
                shouldShowTagLoader: tagTracker.asDriver(onErrorJustReturn: false),
                question1: question1,
                question2: question2,
                question3: question3,
                shouldShowQuestionsLoader: questionsTracker.asDriver(onErrorJustReturn: false),
                hideTagView: hideTagView,
                tagName: tagName,
                tagColor: tagColor
            )
    }
    
    func getModelClasses(_ tracker: ActivityIndicator) -> Observable<[ModelClass]> {
        return services.tags()
            .asObservable()
            .trackActivity(tracker)
            .catchError { error -> Observable<[ModelClass]> in return .empty() }
    }
    
    func getQuestions(slug: String, tracker: ActivityIndicator) -> Observable<Questions> {
        return services.questions(slug: slug)
            .asObservable()
            .trackActivity(tracker)
            .catchError { error -> Observable<Questions> in return .empty() }
    }
}
