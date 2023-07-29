//
//  CopyKeyButton.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 22.06.2023.
//

import UIKit

final class CopyButton: UIButton {
    var textToCopy: String?
    convenience init(text: String?) {
        self.init(frame: .zero)
        self.textToCopy = text 
        configure()
        
    }
}
extension CopyButton {
    private func configure(){
        setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        //setTitle("Copy", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        makeSystem(self)
        addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
    }
    
    @objc func buttonTouched() {
        UIPasteboard.general.string = textToCopy
        UIView.animate(withDuration: 1.0, animations: {
            self.setImage(UIImage(systemName: "checkmark"), for: .normal)
            self.tintColor = .systemGreen
        })
        print("text copied: \(textToCopy ?? "")")
       
    }
}


