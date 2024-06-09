import Foundation

struct LoginInfo: Codable {
    var email: String
    var password: String
    var description: String
    
    static func empty() -> LoginInfo {
        return LoginInfo(email: "", password: "", description: "")
    }
}
