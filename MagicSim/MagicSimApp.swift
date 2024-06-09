import SwiftUI

@main
struct MagicSimApp: App {
    @StateObject private var viewModel = LoginViewModel(datasource: LoginDatasource())

    init() {
        requestAccessibilityPermissions()
    }
    
    var body: some Scene {
        MenuBarExtra("MagicSim", systemImage: "star.fill") {
            ContentView(viewModel: viewModel, simulatorAutomationManager: SimulatorAutomationManager())
        }
        Window("Add Login", id: "add-login-window") {
            LoginFormView(
                onSave: { newLoginInfo in
                    viewModel.saveLogin(newLoginInfo)
                }
            )
        }
    }

    func requestAccessibilityPermissions() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as String: true]
        let _ = AXIsProcessTrustedWithOptions(options)
    }
}
