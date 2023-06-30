//
//  BaseController.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

enum Position {
    case left
    case right
}

class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
    }
}

@objc extension BaseController {
    func addViews() {}
    
    func layoutViews() {}
    
    func configure() {
        view.backgroundColor = Resorces.Colors.backgroundGray
    }
    
    func navBarLeftButtonHandler() {
    }
    func navBarRightButtonHandler() {
    }
}

extension BaseController {
    func addNavBarTextButton(at position: Position, with title: String) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Resorces.Colors.active, for: .normal)
        button.setTitleColor(Resorces.Colors.inactive, for: .disabled)
        button.titleLabel?.font = Resorces.Font.helveticaRegular(with: 17)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
    func addNavBarImageButton(at position: Position, with image: UIImage) {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
}

