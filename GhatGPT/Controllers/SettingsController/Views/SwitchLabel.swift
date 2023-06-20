//
//  SwitchLabel.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 20.06.2023.
//

import UIKit

final class SwitchLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SwitchLabel {
    private func configure() {
        textColor = Resorces.Colors.titleSecondaryLabel
        text = "Streaming message display"
        translatesAutoresizingMaskIntoConstraints = false
        font = Resorces.Font.helveticaRegular(with: 20)
        numberOfLines = 1
    }
}
