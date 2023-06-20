//
//  SettingsController.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 20.06.2023.
//

import UIKit

final class SettingsController: BaseController {
    //MARK: - PROPERTIES
    
    let typeSwitch = SendTypeSwitch()
    let switchLabel = SwitchLabel()
    let keyLabel = KeyLabel()
    let stateKeyLabel = StateKeyLabel()
    let setupButton = SetupKeyButton()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - ADD VIEWS
    override func addViews() {
        super.addViews()
        [typeSwitch, switchLabel, stateKeyLabel, keyLabel, setupButton].forEach({ view.addSubview($0) })
    }
    
    //MARK: - CONFIGURE
    override func configure() {
        super.configure()
        setupButton.label = keyLabel
    }
    
    //MARK: - LAYOUT
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
        
            //typeSwitch
            typeSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            typeSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        
            //switchLabel
            switchLabel.leadingAnchor.constraint(equalTo: typeSwitch.trailingAnchor, constant: 32),
            switchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            switchLabel.centerYAnchor.constraint(equalTo: typeSwitch.centerYAnchor),
            
            //stateKeyLabel
            stateKeyLabel.leadingAnchor.constraint(equalTo: typeSwitch.leadingAnchor),
            stateKeyLabel.topAnchor.constraint(equalTo: typeSwitch.bottomAnchor,constant: 100),
            stateKeyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
            
            //keyLabel
            keyLabel.leadingAnchor.constraint(equalTo: stateKeyLabel.leadingAnchor),
            keyLabel.topAnchor.constraint(equalTo: stateKeyLabel.bottomAnchor,constant: 16),
            keyLabel.trailingAnchor.constraint(equalTo: stateKeyLabel.trailingAnchor),
            
            //setupButton
            setupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setupButton.topAnchor.constraint(equalTo: keyLabel.bottomAnchor,constant: 16),
            
        ])
    }
}

@objc extension SettingsController {
    
}
