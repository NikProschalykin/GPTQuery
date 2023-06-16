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
        view.backgroundColor = Resorces.Colors.background
    }
    
    func navBarLeftButtonHandler() {
        print("left button tapped")
    }
    func navBarRightButtonHandler() {
        print("right button tapped")
    }
}

extension BaseController {
    func addNavBarButton(at position: Position, with title: String) {
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
            self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
}

