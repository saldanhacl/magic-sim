import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var logins: [LoginInfo] = []
    @Published var selectedLogin: LoginInfo?

    private let datasource: LoginDatasource

    init(datasource: LoginDatasource) {
        self.datasource = datasource
        loadLogins()
    }

    func loadLogins() {
        logins = datasource.loadLogins()
    }

    func saveLogin(_ login: LoginInfo) {
        datasource.saveLogin(login)
        loadLogins()
    }
    
    func selectLogin(_ login: LoginInfo) {
        selectedLogin = login
    }
}
