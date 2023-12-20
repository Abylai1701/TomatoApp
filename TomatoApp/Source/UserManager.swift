import Foundation

class UserManager {
    static let shared                 = UserManager()
    private let userDefaults          = UserDefaults.standard
    private let currentUserIdentifier = "currentUserIdentifier"
    private let currentToken          = "currentToken"
    private let isShownOnBoard        = "isShownOnBoard"
    
    private init() {}
    
    func setAccessToken(token: String) {
        userDefaults.set(token, forKey: currentToken)
    }
    func getAccessToken() -> String? {
        return userDefaults.string(forKey: currentToken)
    }
    
    func deleteCurrentSession() {
        userDefaults.set(nil, forKey: currentToken)
        userDefaults.synchronize()
        AppCenter.shared.start()
    }
    func getShownOnBoard() -> Bool? {
        return userDefaults.bool(forKey: isShownOnBoard)
    }
    func setShownOnBoard(isShown: Bool?) {
        userDefaults.set(isShown, forKey: isShownOnBoard)
    }
//    func getUserId() -> Int {
//        return UserManager.shared.getCurrentUser()?.id ?? 0
//    }
//    func createSession(withUser user: UserResponse?) -> Void{
//        guard let user = user else {return}
//        let encoder = JSONEncoder()
//        if let userData = try? encoder.encode(user) {
//            userDefaults.set(userData, forKey: currentUserIdentifier)
//            userDefaults.synchronize()
//        } else {
//            print("can't save user data")
//        }
//    }
//    func getCurrentUser() -> UserResponse? {
//        let decoder = JSONDecoder()
//        if let data = userDefaults.data(forKey: currentUserIdentifier) {
//            if let user = try? decoder.decode(UserResponse.self, from: data) {
//                return user
//            }
//        }
//        return nil
//    }
}
