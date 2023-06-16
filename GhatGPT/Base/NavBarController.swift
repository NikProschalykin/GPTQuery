//
//  NavBarController.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

final class NavBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationBar.isTranslucent = false // чтобы не заканчивался на границе статус бара
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: Resorces.Colors.titleGray,
            .font: Resorces.Font.helveticaRegular(with: 17)
            ]
        
        navigationBar.addBottomBorder(with: Resorces.Colors.separator, height: 1)
    }
}
