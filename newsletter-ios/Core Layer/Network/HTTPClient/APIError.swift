
import Foundation

class APIError:Decodable {
    var type: String?
    var title: String?
    var status: Int?
    var detail, path, message: String?
    
    init(message:String){
        self.message = message
    }
    
}
