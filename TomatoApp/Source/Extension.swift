import UIKit
import Foundation

enum AlertMessageType: String {
    case error = "Ошибка"
    case none = "Внимание"
    case null = ""
}

extension String  {
    var localized: String {
        let lang = LanguageCenter.standard.getLanguage() ?? .en
        if let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        return NSLocalizedString(self, comment: "")
    }
    func localized(_ arguments: String...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    func localized(lang: LanguageType) -> String{
        if let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        return NSLocalizedString(self, comment: "")
    }
    var localizedImage: UIImage? {
        let lang = LanguageCenter.standard.getLanguage() ?? .en
        return UIImage(named: "\(self)_\(lang.rawValue)")
    }
}
enum LanguageType: String {
    case ru = "ru"
    case en = "en"
    
    
    static let shared = LanguageType(rawValue: "en")
}

extension UIViewController {
    func inNavigation() -> UIViewController {
        return UINavigationController(rootViewController: self)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func showLoader() {
        LoaderView.show()
    }
    
    func hideLoader() {
        LoaderView.hide()
    }
    func showErrorMessage(messageType: AlertMessageType,
                          _ message: String,
                          completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: messageType.rawValue, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                if let completionHandler = completion {
                    self.dismiss(animated: true, completion: nil)
                    completionHandler()
                }
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showSuccessMessage(completion: (() -> ())? = nil) -> Void {
        let alertController = UIAlertController(title: "success".localized, message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                alertController.dismiss(animated: true) {
                    if let completionHandler = completion {
                        completionHandler()
                    }
                }
            }
        })
    }
    
    func showSubmitMessage(messageType: AlertMessageType,
                           _ message: String,
                           completion: (@escaping () -> Void)) {
        let alertController = UIAlertController(title: messageType.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "yes".localized, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "no".localized, style: .default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIFont {
    static func montserratLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Light", size: size)!
    }
    static func montserratRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    static func montserratMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size)!
    }
    static func montserratSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size)!
    }
    static func montserratBoldItalic(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-BoldItalic", size: size)!
    }
}
extension UIView {
    
    func addSubviews(_ views : UIView...) -> Void {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
}
extension UICollectionViewCell {
    
    static var cellId: String {
        return String(describing: self)
    }
    
}
extension UITableViewCell {
    
    static var cellId: String {
        return String(describing: self)
    }
    
    func convertTimeIntervalString(_ originalString: String) -> String {
        var components = originalString.components(separatedBy: " ")
        
        for (index, component) in components.enumerated() {
            if component == "days" {
                components[index] = "д"
            } else if component == "hours" {
                components[index] = "ч"
            } else if component == "minuts" {
                components[index] = "м"
            }
        }
        
        let result = components.joined(separator: " ")
        return result
    }
}
