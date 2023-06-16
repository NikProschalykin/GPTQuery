//
//  SendButton.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

final class SendButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setBackgroundImage(UIImage(systemName: "paperplane"), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        tintColor = .systemGreen
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}
@objc extension SendButton {
    func buttonAction() {
        print("tapped")
    }
}
