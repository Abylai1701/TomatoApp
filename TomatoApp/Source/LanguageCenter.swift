import Foundation

class LanguageCenter {
    
    static let standard = LanguageCenter()
    private init() {}
    let key = "language"
    
    func getLanguage() -> LanguageType? {
        return LanguageType(rawValue: UserDefaults.standard.string(forKey: key) ?? "kk-KZ")
    }
    
    func setLanguage(language: LanguageType) -> Void {
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(language.rawValue, forKey: self.key)
            UserDefaults.standard.synchronize()
        }
    }
    
}
