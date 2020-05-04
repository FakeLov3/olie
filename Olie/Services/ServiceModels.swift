import UIKit

struct ModelClass: Decodable {
    
    var color: UIColor {
        switch slug {
        case "condicao":
            return .secondary
            
        case "oferta":
            return .support1
            
        case "estoque":
            return .support2
            
        case "entrega":
            return .support3
            
        case "cor":
            return .support4
            
        case "agradecimento":
            return .support5
            
        case "fotos":
            return .support6
            
        case "acessorios":
            return .secondary
            
        case "contato":
            return .support1
            
        case "brinde":
            return .support2
            
        case "garantia":
            return .support3
            
        case "frete":
            return .support4
            
        case "original":
            return .support5
            
        case "nf":
            return .support6
            
        case "especificacoes-tecnicas":
            return .secondary
            
        case "pagamento":
            return .support1
            
        default:
            return .black
        }
    }
    
    let id: Int
    let slug: String
    let name: String
}

struct Questions: Decodable {
    let sample_questions: [String]
}
