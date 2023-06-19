//
//  MessageTextField.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

final class MessageTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        placeholder = "Text your message here"
        font = Resorces.Font.helveticaRegular(with: 17)
        textColor = .black
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        textAlignment = .natural
        autocorrectionType = .no
        translatesAutoresizingMaskIntoConstraints = false
        
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        leftViewMode = .always
        leftView = spacerView
    }
    
}
