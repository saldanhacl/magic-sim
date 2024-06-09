import Foundation

class LoginDatasource {
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("logins.json")
    }

    func loadLogins() -> [LoginInfo] {
        if let data = try? Data(contentsOf: fileURL),
           let savedLogins = try? JSONDecoder().decode([LoginInfo].self, from: data) {
            return savedLogins
        }
        return []
    }

    func saveLogin(_ login: LoginInfo) {
        var logins = loadLogins()
        logins.append(login)
        if let data = try? JSONEncoder().encode(logins) {
            try? data.write(to: fileURL)
        }
    }
}
