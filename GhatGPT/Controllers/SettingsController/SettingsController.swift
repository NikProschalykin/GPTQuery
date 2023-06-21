//
//  SettingsController.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 20.06.2023.
//

import UIKit

final class SettingsController: BaseController {
    //MARK: - PROPERTIES
    
    private let displayBlock = DisplayBlock()
    let apiKeyBlock = ApiKeyBlock()
    //var settings = Settings.shared
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - ADD VIEWS
    override func addViews() {
        super.addViews()
        
        [displayBlock, apiKeyBlock].forEach({ view.addSubview($0) })
      
    }
    
    //MARK: - CONFIGURE
    override func configure() {
        super.configure()
        apiKeyBlock.setupButton.vc = self
        print(Settings.shared.apiKey)
    }
    
    //MARK: - LAYOUT
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
        
            //displayMessageStack
            displayBlock.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            displayBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            displayBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            displayBlock.heightAnchor.constraint(equalToConstant: 40),
            

            //setupButton
            apiKeyBlock.leadingAnchor.constraint(equalTo: displayBlock.leadingAnchor),
            apiKeyBlock.trailingAnchor.constraint(equalTo: displayBlock.trailingAnchor),
            apiKeyBlock.heightAnchor.constraint(equalToConstant: 150),
            apiKeyBlock.topAnchor.constraint(equalTo: displayBlock.bottomAnchor, constant: 100),
        ])
    }
}

@objc extension SettingsController {
    
}
