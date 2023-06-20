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

// MARK: - Сепаратор

extension UIView {
    
    enum SeparatorPosition {
        case top
        case bottom
        case left
        case right
    }

    @discardableResult
    func addSeparator(at position: SeparatorPosition, color: UIColor, weight: CGFloat = 1.0 / UIScreen.main.scale, insets: UIEdgeInsets = .zero) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        switch position {
        case .top:
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left).isActive = true
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insets.right).isActive = true
            view.heightAnchor.constraint(equalToConstant: weight).isActive = true
            
        case .bottom:
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left).isActive = true
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insets.right).isActive = true
            view.heightAnchor.constraint(equalToConstant: weight).isActive = true
            
        case .left:
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left).isActive = true
            view.widthAnchor.constraint(equalToConstant: weight).isActive = true
            
        case .right:
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom).isActive = true
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insets.right).isActive = true
            view.widthAnchor.constraint(equalToConstant: weight).isActive = true
        }
        
        return view
    }
}


//MARK: - Анимация нажатия кнопки как системной
extension UIView {
    func makeSystem(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [.touchDown,
                                                                  .touchDragInside
        ])
        button.addTarget(self, action: #selector(handleOut), for: [.touchUpInside,
                                                                   .touchDragOutside,
                                                                   .touchUpOutside,
                                                                   .touchDragExit,
                                                                   .touchCancel
        ])
    }
    
    @objc func handleIn() {
        UIView.animate(withDuration: 0.45) { self.alpha = 0.55 }
    }
    
    @objc func handleOut() {
        UIView.animate(withDuration: 0.45) { self.alpha = 1  }
    }
}

