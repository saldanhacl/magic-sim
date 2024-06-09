import Cocoa

class SimulatorTracker {
    static let shared = SimulatorTracker()
    private var timer: Timer?
    private var previousSimulatorFrame: CGRect?

    private init() {}

    func startTrackingSimulator() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.016,
            target: self,
            selector: #selector(updatePosition),
            userInfo: nil,
            repeats: true
        )
    }

    func stopTrackingSimulator() {
        timer?.invalidate()
        timer = nil
    }

    @objc
    private func updatePosition() {
        guard let simulatorFrame = findSimulatorWindowFrame() else {
//            print("Simulator not found")
            return
        }

        if previousSimulatorFrame == nil || !previousSimulatorFrame!.equalTo(simulatorFrame) {
            previousSimulatorFrame = simulatorFrame
            positionNextToSimulator(simulatorFrame: simulatorFrame)
        }
    }

    private func positionNextToSimulator(simulatorFrame: CGRect) {
        guard let window = NSApplication.shared.windows.first, let screenFrame = NSScreen.main?.frame else { return }

        let appFrame = window.frame
        let topLeftCornerAligmentOrigin = simulatorFrame.origin.x - appFrame.size.width - 10
        let verticalAlignmentOrigin = screenFrame.height - simulatorFrame.origin.y - appFrame.size.height

        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.1
            window.animator().setFrameOrigin(NSPoint(x: topLeftCornerAligmentOrigin, y: verticalAlignmentOrigin))
        }
    }

    private func findSimulatorWindowFrame() -> CGRect? {
        let windowListInfo = CGWindowListCopyWindowInfo(
            [.optionOnScreenOnly],
            kCGNullWindowID
        ) as NSArray? as? [[String: Any]]

        for windowInfo in windowListInfo ?? [] {
            if let ownerName = windowInfo[kCGWindowOwnerName as String] as? String,
               ownerName == "Simulator",
               let boundsDict = windowInfo[kCGWindowBounds as String] as? [String: CGFloat],
               let x = boundsDict["X"],
               let y = boundsDict["Y"],
               let width = boundsDict["Width"],
               let height = boundsDict["Height"]
            {
                return CGRect(x: x, y: y, width: width, height: height)
            }
        }
        return nil
    }
}
