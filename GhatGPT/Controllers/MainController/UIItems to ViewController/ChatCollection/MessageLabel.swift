//
//  MessageLabel.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 16.06.2023.
//

import UIKit

final class MessageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MessageLabel {
    private func configure() {
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        font = Resorces.Font.helveticaRegular(with: 17)
        numberOfLines = 0
    }
}
