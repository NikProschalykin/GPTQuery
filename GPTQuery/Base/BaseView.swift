//
//  BaseView.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

@objc extension BaseView {
    func addViews() {}
    
    func layoutViews() {}
    
    func configure() {
        backgroundColor = Resorces.Colors.background
        translatesAutoresizingMaskIntoConstraints = false
    }
}
