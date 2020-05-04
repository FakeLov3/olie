import Alamofire
import RxSwift

final class Services: ServicesProtocol {
    func questions(slug: String) -> Single<Questions> {
        return .create(subscribe: { single in
          
            let request = AF.request("https://olie.tech/api/v1/tags/\(slug)")
            
            request.responseDecodable(of: Questions.self) { (response) in
                
                if let value = response.value {
                    single(.success(value))
                } else {
                    single(.error(ServiceError.genericError))
                }
            }
            
            return Disposables.create()
        })
    }

    
    func tags() -> Single<[ModelClass]> {
        return .create(subscribe: { single in
          
            let request = AF.request("https://olie.tech/api/v1/tags/")
            
            request.responseDecodable(of: [ModelClass].self) { (response) in
                
                if let value = response.value {
                    single(.success(value))
                } else {
                    single(.error(ServiceError.genericError))
                }
            }
            
            return Disposables.create()
        })
    }
}
