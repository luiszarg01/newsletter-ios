import Foundation
import Alamofire
import Sniffer

class APISessionManager: SessionManager {
    
    static var shared: APISessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        Sniffer.enable(in: configuration)
        
        let manager = APISessionManager(configuration: configuration)
        return manager
    }()
    
}
