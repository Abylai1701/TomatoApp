import UIKit

final class AppCenter {
    
    //MARK: - Properties
    private var window = UIWindow()
    static let shared = AppCenter()
    
    func createWindow(_ window: UIWindow) -> Void {
        self.window = window
    }
    func start() -> Void{
        makeKeyAndVisible()
        makeRootController()
    }
    private func makeKeyAndVisible() {
        self.window.makeKeyAndVisible()
        self.window.backgroundColor = .white
    }
    private func makeRootController() {
        let vc = MainController().inNavigation()
        setRootController(vc)
    }
    private func setRootController(_ controller: UIViewController) -> Void {
        self.window.rootViewController = controller
    }
}
