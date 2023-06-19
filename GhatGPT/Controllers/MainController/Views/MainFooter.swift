//
//  MainFooter.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

final class MainFooter: BaseView {
    
    let textView = MessageTextView()
    private let sendButton = SendButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainFooter {
    override func addViews() {
        super.addViews()
        
        
        addSubview(sendButton)
        addSubview(textView)
        
    }
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            
            textView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: 40),
            textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
        
        ])
    }
    
}
