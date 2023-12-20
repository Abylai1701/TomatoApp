import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppCenter.shared.createWindow(UIWindow(frame: UIScreen.main.bounds))
        AppCenter.shared.start()
        return true
    }


}

