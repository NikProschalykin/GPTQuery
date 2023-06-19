//
//  MessageTextView.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 16.06.2023.
//

import UIKit

final class MessageTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = Resorces.Font.helveticaRegular(with: 17)
        backgroundColor = .systemGray4
        textColor = .black
        autocorrectionType = .no
        text = "Message"
        textColor = UIColor.lightGray
    }
}


