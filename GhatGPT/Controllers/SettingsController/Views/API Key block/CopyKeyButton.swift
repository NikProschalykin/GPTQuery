//
//  CopyKeyButton.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 22.06.2023.
//

import UIKit

final class CopyKeyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CopyKeyButton {
    private func configure(){
        setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        //setTitle("Copy", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        makeSystem(self)
        addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
    }
    
    @objc func buttonTouched() {
        UIPasteboard.general.string = Settings.shared.apiKey
        UIView.animate(withDuration: 1.0, animations: {
            self.setImage(UIImage(systemName: "checkmark"), for: .normal)
            self.tintColor = .systemGreen
        })
       
    }
}


