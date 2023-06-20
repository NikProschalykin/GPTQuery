//
//  ShowKeyButton.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 20.06.2023.
//

import UIKit

final class SetupKeyButton: UIButton {
   weak var label: UILabel?
    
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
        setTitleColor(Resorces.Colors.titleSecondaryLabel, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        //backgroundColor = .systemGray3
//        layer.borderColor = UIColor.systemBackground.cgColor
//        layer.borderWidth = 2
//        layer.cornerRadius = 10
        makeSystem(self)
        addTarget(self, action: #selector(setupKey), for: .touchUpInside)
    }
}

@objc extension SetupKeyButton {
    func setupKey() {
        guard let label = self.label else { return }
        print("button tapped")
        print(label.text)
    }
}
