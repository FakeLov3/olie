import RxSwift
import RxCocoa
import UIKit.UIImage

final class FeedbackViewModel {
    
    let services: ServicesProtocol
    
    init(services: ServicesProtocol) {
        self.services = services
    }
    
    func staticInput() -> (
        image: Driver<UIImage?>,
        text1: Driver<String>,
        text2: Driver<String>,
        text3: Driver<String>,
        text4: Driver<String>
        ) {
            return (
                image: .just(UIImage(named: "image_feedback")),
                text1: .just("Resposta enviada!"),
                text2: .just("Com sua resposta, vamos conseguir responder as dúvidas mais rápido e aumentar suas chances de venda!"),
                text3: .just("Está com tempo?"),
                text4: .just("Responda mais perguntas frequentes e aumente suas chances de venda!")
            )
    }
    
    func dynamicInput() -> (
        tags: Driver<[Tag]>,
        b: Driver<Void>
        ) {
            
            let tags = getModelClasses()
                .map { $0.map { Tag(color: $0.color, name: $0.name) } }
                .asDriver(onErrorJustReturn: [])
            
            return (
                tags: tags,
                b: .never()
            )
    }
    
    func getModelClasses() -> Observable<[ModelClass]>{
        return services.tags()
            .asObservable()
            .catchError { error -> Observable<[ModelClass]> in return .empty() }
    }
}
