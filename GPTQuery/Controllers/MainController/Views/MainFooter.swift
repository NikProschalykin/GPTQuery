//
//  MainFooter.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

final class MainFooter: BaseView {
    
    let textView = MessageTextView()
    let sendButton = SendButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainFooter {
    
    override func configure() {
        super.configure()
        
        backgroundColor = .systemGray5
        textView.delegate = sendButton.self
        addSeparator(at: .top, color: Resorces.Colors.separator,weight: 1)
    }
    
    override func addViews() {
        super.addViews()
        
        
        addSubview(sendButton)
        addSubview(textView)
        
    }
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            
            textView.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 35),
            sendButton.heightAnchor.constraint(equalToConstant: 35),
        
        ])
    }
}


