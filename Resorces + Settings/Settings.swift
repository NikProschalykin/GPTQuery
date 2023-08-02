import UIKit

enum Mode: Int {
    case full = 1
    case stream = 2
}

final class Settings {
    static let shared = Settings()
    
    var messageMode: Mode = Mode(rawValue: UserDefaults.standard.integer(forKey: "messageMode")) ?? .stream
    
    var apiKey = setupToken(for: "admin") {
        willSet { chatGptApi = ChatAPI(apiKey: newValue) }
    }
    
    lazy var chatGptApi = ChatAPI(apiKey: apiKey)
    
    private init() {}
}

extension Settings {
    static func setupToken(for account: String) -> String {
        var token: String = ""
        
        do {
           let data = try KeyChainManager.getToken(for: account)
           token = String(decoding: data ?? Data(), as: UTF8.self)
        } catch {
            print(error)
        }
        
        return token
    }
}
