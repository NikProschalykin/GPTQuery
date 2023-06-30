//
//  DisplayBlock.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 21.06.2023.
//

import UIKit
final class DisplayBlock: BaseView {
    
    private let typeSwitch = SendTypeSwitch()
    private let switchLabel = SwitchLabel()
    
}
extension DisplayBlock {
    override func configure() {
        super.configure()
        backgroundColor = Resorces.Colors.settingsBlocksBackground
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
    }
    override func addViews() {
        super.addViews()
        addSubview(typeSwitch)
        addSubview(switchLabel)
    }
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            switchLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            switchLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            typeSwitch.centerYAnchor.constraint(equalTo: switchLabel.centerYAnchor),
            typeSwitch.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            typeSwitch.leadingAnchor.constraint(equalTo: switchLabel.trailingAnchor,constant: 16),
        ])
    }
}
