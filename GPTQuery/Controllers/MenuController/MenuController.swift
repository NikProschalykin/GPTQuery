//
//  MenuController.swift
//  GPTQuery
//
//  Created by Николай Прощалыкин on 17.07.2023.
//

import UIKit

final class MenuController: BaseController {
    //MARK: - PROPERTIES
    let tableView = HistoryTableView()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - ADD VIEWS
    override func addViews() {
        super.addViews()
        view.addSubview(tableView)
    }
    
    //MARK: - CONFIGURE
    override func configure() {
        super.configure()
        title = "Menu"
        addNavBarButton(at: .right, with: UIImage(systemName: "gearshape")!)
    }
    
    
    //MARK: - LAYOUT
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            //tableView
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor ,constant: -2),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -2),
        ])
    }
}
//MARK: - Extensions

//MARK: - Открытие экрана настроек на половину 
extension MenuController {
    
    override func navBarRightButtonHandler() {
        let vc = SettingsController()
        if let presentationController = vc.presentationController as? UISheetPresentationController {
                    presentationController.detents = [.medium()]
                }
        present(vc, animated: true)
    }
}

extension MenuController {
    
}


