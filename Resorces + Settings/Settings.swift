//
//  Settings.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 21.06.2023.
//

import UIKit

enum Mode {
    case full
    case stream
}

final class Settings {
    static let shared = Settings()
    
    var messageMode: Mode = .full
    var apiKey = "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" {
        willSet {
            chatGptApi = ChatAPI(apiKey: newValue)
        }
    }
    lazy var chatGptApi = ChatAPI(apiKey: apiKey)
    
    private init() {}
}
