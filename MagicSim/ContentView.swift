import SwiftUI

struct ContentView: View {
    @Environment(\.openWindow) var openWindow
    @ObservedObject var viewModel: LoginViewModel
    let simulatorAutomationManager: SimulatorAutomationManager

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Selected: \(viewModel.selectedLogin?.description ?? "-")")
                .font(.headline)
                .padding(.bottom, 5)
            Divider()

            Menu("Change login") {
                ForEach(viewModel.logins, id: \.email) { login in
                    Button(action: {
                        viewModel.selectLogin(login)
                    }) {
                        Text(login.description)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Button(action: {
                openWindow(id: "add-login-window")
            }, label: {
                Text("Add login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            
            Button(action:  {
                guard let selectedLogin = viewModel.selectedLogin else { return }
                simulatorAutomationManager.fillLoginDetails(selectedLogin)
            }, label: {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            .disabled(viewModel.selectedLogin == nil)
            Divider()

            Button(action: {
                NSApplication.shared.terminate(nil)
            }, label: {
                Text("Exit App")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
        }
        .padding()
        .frame(width: 200)
    }
}
