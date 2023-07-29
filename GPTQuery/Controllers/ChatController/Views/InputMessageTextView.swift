//
//  MessageTextView.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 16.06.2023.
//

import UIKit

final class InputMessageTextView: UITextView {
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
        autocorrectionType = .no
        text = Resorces.Strings.ChatStrings.textViewPlaceHolder
        textColor = UIColor.lightGray
        layer.cornerRadius = 10
    }
}


