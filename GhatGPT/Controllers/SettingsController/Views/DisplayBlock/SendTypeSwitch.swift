//
//  SendTypeSwitch.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 20.06.2023.
//

import UIKit

final class SendTypeSwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SendTypeSwitch {
    private func configure() {
        (Settings.shared.messageMode == .stream) ? (isOn = true) : (isOn = false)
        
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
    }
}

@objc extension SendTypeSwitch {
    func switchAction(sender: UISwitch) {
        sender.isOn ? (Settings.shared.messageMode = .stream) : (Settings.shared.messageMode = .full)
    }
}
