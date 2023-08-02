import UIKit

final class ApiKeyBlock: BaseView {
    
    private let keyLabel = KeyLabel()
    private let stateKeyLabel = StateKeyLabel()
    let setupButton = SetupKeyButton()
    private let copyButton = CopyButton(text: Settings.shared.apiKey)
    
}
extension ApiKeyBlock {
    override func configure() {
        super.configure()
        setupButton.label = keyLabel
        backgroundColor = Resorces.Colors.settingsBlocksBackground
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
    }
    
    override func addViews() {
        super.addViews()
        [stateKeyLabel, keyLabel, setupButton, copyButton].forEach({ self.addSubview($0) })
    }
    
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            //stateKeyLabel
            stateKeyLabel.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            stateKeyLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            stateKeyLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            
            //keyLabel
            keyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            keyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            //setupButton
            setupButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            setupButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
            
            //copyButton
            copyButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            copyButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
        ])
    }
}


