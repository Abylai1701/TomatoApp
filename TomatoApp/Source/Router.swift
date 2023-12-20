import Foundation
import UIKit

class Router {

    static let shared = Router()

    private init() {}

    private var currentController: UIViewController = UIViewController()

    func setCurrentViewController(_ controller: UIViewController) -> Void {
        self.currentController = controller
    }

    func getCurrentViewController() -> UIViewController {
        return currentController
    }

    func push(_ viewController: UIViewController,
              animated: Bool? = true ) -> Void {
        hideLoader()
        Router.shared.hideLoader()
        if let tabBarController = currentController.tabBarController {
            tabBarController.navigationController?.pushViewController(viewController, animated: animated ?? true)
        }
        else {
            currentController.navigationController?.pushViewController(viewController, animated: animated ?? true)
        }
        
    }

    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = currentController.navigationController?.viewControllers.last(where: { $0.isKind(of: ofClass)}) {
            currentController.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    func pop(animated: Bool? = true) -> Void {
        if let tabBarController = currentController.tabBarController {
            tabBarController.navigationController?.popViewController(animated: animated ?? true)
        }
        else if let navigationController = currentController.navigationController {
            navigationController.popViewController(animated: animated ?? true)
        }
        else {
            currentController.navigationController?.popViewController(animated: animated ?? true)
        }
    }

    func show(_ viewController: UIViewController, completion: (() -> ())? = nil) -> Void {
        if let tabBarController = currentController.tabBarController {
            tabBarController.present(viewController, animated: true, completion: completion)
        } else {
            currentController.present(viewController, animated: true, completion: completion)
        }
    }
    
    func dismiss(completion: (() -> ())? = nil) {
        if let tabBarController = currentController.tabBarController {
            tabBarController.dismiss(animated: true, completion: completion)
        } else if let navigationController = currentController.navigationController {
            navigationController.dismiss(animated: true, completion: completion)
        } else {
            currentController.dismiss(animated: true, completion: completion)
        }
    }


    func showLoader() -> Void {
        currentController.showLoader()
    }

    func hideLoader() -> Void {
        currentController.hideLoader()
    }

    func showErrorMessage(type: AlertMessageType, message: String,
                          completion: (() -> Void)? = nil) -> Void {
        currentController.showErrorMessage(messageType: type, message,
                                           completion: completion)
    }

    func showSubmitMessage(message: String, completion: @escaping () -> ()) -> Void {
        currentController.showSubmitMessage(messageType: .none, message, completion: completion)
    }

    func showSuccessMessage(message: String? = nil, completion: (() -> ())? = nil) -> Void {
        currentController.showSuccessMessage(completion: completion)
    }
    
    func share(text: String) {
        
        let items = ["Кім ақылды екенін тексерейік? \n\nБонус алу промо-коды:\(text)\n\nAqyl Battle ойынын төмендегі сілтемеге өтіп, жүктеп алыңыз... \nhttps://onelink.to/nbqxhv"]
        self.show(UIActivityViewController(activityItems: items, applicationActivities: nil))
    }
    
    func shareWSFeedback(){
        let urlStringEncoded = "".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let appURL = URL(string: "https://wa.me/\("+77079467141")?text=\(urlStringEncoded)") else { print("WRONG whatsapp URL"); return; }
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
}
