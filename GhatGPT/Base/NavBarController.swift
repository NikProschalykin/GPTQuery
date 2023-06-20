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
        view.backgroundColor = Resorces.Colors.backgroundGray
        navigationBar.isTranslucent = false // чтобы не заканчивался на границе статус бара
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: Resorces.Colors.titleLabel,
            .font: Resorces.Font.helveticaRegular(with: 17)
            ]
        
        navigationBar.addSeparator(at: .bottom, color: Resorces.Colors.separator,weight: 1)
    }
}
