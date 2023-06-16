//
//  BaseUIView.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

// MARK: - Присвоение идентификатора к UIView

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
}

// MARK: - Сепаратор снизу

extension UIView {
    func addBottomBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: 0,
                                 y: frame.height - height,
                                 width: frame.width,
                                 height: height)
    addSubview(separator)
    }
}
