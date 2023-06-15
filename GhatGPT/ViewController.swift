//
//  ViewController.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {
// 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 - Данин
    static var apiKey = "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"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let api = ChatAPI(apiKey: ViewController.apiKey)
            do {
//                //потоковый
//                let stream = try await api.sendMessageStream(text: "What is James Bond")
//                for try await line in stream {
//                    print(line)
//                }
                
                //непотоковый
                let text = try await api.sendMessage("What is James bond?")
                print(text)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }


}

