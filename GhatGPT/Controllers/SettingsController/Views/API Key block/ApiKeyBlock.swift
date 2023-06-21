//
//  ApiKeyBlock.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 21.06.2023.
//

import UIKit
final class ApiKeyBlock: BaseView {
    
    private let keyLabel = KeyLabel()
    private let stateKeyLabel = StateKeyLabel()
    let setupButton = SetupKeyButton()
    
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
        [stateKeyLabel, keyLabel, setupButton].forEach({ self.addSubview($0) })
    }
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            
            //stateKeyLabel
            stateKeyLabel.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            stateKeyLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            stateKeyLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            
            //keyLabel
//            keyLabel.topAnchor.constraint(equalTo: stateKeyLabel.bottomAnchor,constant: 16),
//            keyLabel.leadingAnchor.constraint(equalTo: stateKeyLabel.leadingAnchor),
//            keyLabel.trailingAnchor.constraint(equalTo: stateKeyLabel.trailingAnchor),
            keyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            keyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            //setupButton
            setupButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            setupButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
        ])
    }
}


