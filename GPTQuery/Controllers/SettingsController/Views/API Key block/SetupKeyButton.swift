import UIKit

final class SetupKeyButton: UIButton {
    
   weak var label: UILabel?
   weak var delegate: SetupKeyButtonDelegate?
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
        delegate?.apiKeyBlock.shake()
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
                do {
                   let status = try KeyChainManager.updateToken(token: key.data(using: .utf8) ?? Data(), for: "admin")
                    Settings.shared.apiKey = Settings.setupToken(for: "admin")
                } catch { print(error) }
            } else {
                self.wrongKey()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.isCorrectInputKey = true
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        delegate?.present(alertController,animated: true)
    }
}

