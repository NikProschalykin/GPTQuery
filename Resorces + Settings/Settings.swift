//
//  Settings.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 21.06.2023.
//

import UIKit

enum Mode: Int {
    case full = 1
    case stream = 2
}

final class Settings {
    static let shared = Settings()
    
    var messageMode: Mode = Mode(rawValue: UserDefaults.standard.integer(forKey: "messageMode")) ?? .full
    
    var apiKey = "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" { //s
        willSet {
            chatGptApi = ChatAPI(apiKey: newValue)
        }
    }
    lazy var chatGptApi = ChatAPI(apiKey: apiKey)
    
    private init() {}
}
