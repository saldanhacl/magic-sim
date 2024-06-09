import SwiftUI

struct LoginFormView: View {
    var onSave: (LoginInfo) -> Void
    @Environment(\.dismissWindow) var dismissWindow

    @State private var loginInfo: LoginInfo = LoginInfo.empty()
    
    var body: some View {
        VStack {
            Text("Add Login")
                .font(.headline)
                .padding()

            TextField("Email", text: $loginInfo.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Password", text: $loginInfo.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $loginInfo.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button("Cancel") {
                    dismissWindow(id: "add-login-window")
                }
                .padding()

                Spacer()

                Button("Save") {
                    onSave(loginInfo)
                    dismissWindow(id: "add-login-window")
                }
                .padding()
            }
        }
        .frame(width: 300, height: 300)
        .padding()
    }
}
