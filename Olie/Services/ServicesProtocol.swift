import RxSwift

protocol ServicesProtocol {
    func tags() -> Single<[ModelClass]>
    func questions(slug: String) -> Single<Questions>
    func answer(_ answer: Answer) -> Single<Void>
}
