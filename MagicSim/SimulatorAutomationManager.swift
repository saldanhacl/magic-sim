import Foundation

class SimulatorAutomationManager {
    func fillLoginDetails(_ login: LoginInfo) {
        func typeText(_ text: String) -> String {
            var script = ""
            for character in text {
                script += "keystroke \"\(character)\"\n"
            }
            return script
        }

        let emailScript = typeText(login.email)
        let passwordScript = typeText(login.password)

        let script = """
        tell application "System Events"
            tell process "Simulator"
                set frontmost to true
                    delay 1
                    key code 48 -- tab
                    key code 48 -- tab
                    key code 48 -- tab
                    delay 1
                    \(emailScript)
                    delay 2
                    key code 48 -- tab
                    key code 48 -- tab
                    key code 48 -- tab
                    delay 1
                    \(passwordScript)
                    delay 2
                    key code 48 -- tab
                    key code 48 -- tab
                    key code 36 -- enter
            end tell
        end tell
        """

        DispatchQueue.global(qos: .userInitiated).async {
            
            var error: NSDictionary?
            if let scriptObject = NSAppleScript(source: script) {
                scriptObject.executeAndReturnError(&error)
                
            }
            
            if let error = error {
                print("Error: \(error)")
            }
            
        }
    }
}
