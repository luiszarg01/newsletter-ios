import Foundation
import Alamofire
import Sniffer

class APISessionManager: SessionManager {
    
    //solo exista una instancia en al
    static var shared: APISessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // tiempo de espera de la peticion
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData //ignorar el cache de las llamadas a los servicios
        
        Sniffer.enable(in: configuration)
        
        let manager = APISessionManager(configuration: configuration)
        return manager
    }()
    
}
