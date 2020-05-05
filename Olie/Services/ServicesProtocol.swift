import RxSwift

protocol ServicesProtocol {
    func tags() -> Single<[ModelClass]>
    func questions(slug: String) -> Single<Questions>
    func anwser(_ awnser: Awnser) -> Single<Void>
}
