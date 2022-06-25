
import Foundation
import Alamofire
import Sniffer

typealias APIHeaders = HTTPHeaders

typealias APIParameters = [String:Any]

enum APIMethod{
    case get
    case post
    case delete
    case put
    fileprivate var value: HTTPMethod{
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .delete:
            return HTTPMethod.delete
        }
    }
}

enum APIEncoding{
    case json
    case url
    
    fileprivate var value:ParameterEncoding {
        switch self {
        case .json:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}

class HTTPClient {

    class func request<T:Codable>(endpoint:String,
                                  method:APIMethod = .get,
                                  encoding: APIEncoding  = .url,
                                  parameters: APIParameters? = nil,
                                  headers:APIHeaders? = nil,
                                  onSuccess: @escaping (T) -> Void,
                                  onFailure: ((APIError) -> Bool)? = nil) {
        
        
        let header = headers ?? getHeaders()

        let decoder = JSONDecoder()
        
        let defaultErrorHandler = { (data: Data) in
            
            guard let error = try? decoder.decode(APIError.self, from: data) else { return }
            
            //handle by error type cases
            switch error.type! {
            case "--": // Session expired.

                break
            default:
                break
            }
        }
        
        let handleError = { (data: Data?) in
            guard let data = data else {
                return
            }
            
            if let error = try? decoder.decode(APIError.self, from: data) {
                let wasHandled = onFailure?(error)
                if wasHandled == nil || (wasHandled != nil) == false {
                    defaultErrorHandler(data)
                }
            } else {
                let errorCustom = APIError.init(message:"Ocurrió un error.")
                _ = onFailure?(errorCustom)
            }
        }
        
        let request = APISessionManager.shared.request(EndPoints.baseURL + endpoint,
                                                       method: method.value,
                                                       parameters: parameters,
                                                       encoding:encoding.value,
                                                       headers: header)
        
        
        request.responseJSON(completionHandler: { response in
            request.responseJSON(completionHandler: { response in
                
                guard (response.response?.statusCode == 200 || response.response?.statusCode == 201 ) && response.error == nil, let data = response.data else {
                    handleError(response.data)
                    return
                }
                
                do {
                    let obj = try decoder.decode(T.self, from: data)
                    onSuccess(obj)
                } catch let e {
                    print(e)
                    handleError(response.data)
                }
                
            })
            
        })
    }
    
    
    class func getHeaders() -> HTTPHeaders {
        let headers = [
            "Accept"                    : "application/json",
            "Content-Type"              : "application/json",
            "charset"                   : "utf-8"
        ]
       
        return headers
    }

}


struct EndPoints {
    
    static let baseURL = "https://jsonplaceholder.typicode.com/"
    
}

