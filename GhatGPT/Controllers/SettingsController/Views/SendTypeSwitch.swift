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
        translatesAutoresizingMaskIntoConstraints = false
    }
}
