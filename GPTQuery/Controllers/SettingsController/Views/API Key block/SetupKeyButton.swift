//
//  ShowKeyButton.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 20.06.2023.
//

import UIKit

final class SetupKeyButton: UIButton {
   weak var label: UILabel?
   weak var vc: SettingsController?
   var isCorrectInputKey = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SetupKeyButton {
    private func configure() {
        setTitle("SETUP API Key", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        makeSystem(self)
        addTarget(self, action: #selector(setupKey), for: .touchUpInside)
    }
    
    private func wrongKey() {
        vc?.apiKeyBlock.shake()
        isCorrectInputKey = false
        setupKey()
    }
}

@objc extension SetupKeyButton {
    func setupKey() {
        let title = isCorrectInputKey ? "API key installation" : "TOO SHORT OR WRONG KEY"
        let alertController = UIAlertController(title: title, message: "Enter your API KEY", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            textField.placeholder = "key"
        })
        
        
        let okAction = UIAlertAction(title: "Done", style: .default) { [weak alertController] _ in
            let key = alertController?.textFields![0].text ?? ""
            
            if key.count == 51 {
            print(key)
                do {
                   let status = try KeyChainManager.updateToken(token: key.data(using: .utf8) ?? Data(), for: "admin")
                    Settings.shared.apiKey = Settings.setupToken(for: "admin")
                    print(status)
                } catch {
                    print(error)
                }
                
                //Settings.shared.apiKey = key
            }  else {
                self.wrongKey()
            }
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.isCorrectInputKey = true
        }
        alertController.addAction(cancelAction)
        
        vc?.present(alertController,animated: true)
    }
}

