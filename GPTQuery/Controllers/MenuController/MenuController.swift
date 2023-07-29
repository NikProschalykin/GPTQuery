//
//  MenuController.swift
//  GPTQuery
//
//  Created by Николай Прощалыкин on 17.07.2023.
//

import UIKit
import RealmSwift

final class MenuController: BaseController {
    //MARK: - PROPERTIES
    let tableView = HistoryTableView()
    
    var chatsModel: [ChatModel] = []
    var realmToken: NotificationToken?
    
    var dateChatsArray: [[ChatModel]] = []
    
    let realmServise = RealmService()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        realmToken = realmServise.localRealm.observe({ [weak self] _,realm in
            self?.setupData()
        })
        
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
        addNavBarButton(at: .left, with: UIImage(systemName: "plus"))
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
    override func navBarLeftButtonHandler() {
        let vc = ChatController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK: - Подготовка данных из бд
extension MenuController {
    private func setupData() {
        chatsModel = realmServise.localRealm.objects(ChatModel.self).map({ $0 })
        print("Чатов в моделе: \(chatsModel.count)")

        let sorted = chatsModel.sorted(by: {
            return $0.date > $1.date
        })


        var dateChatsDicts: [String : [ChatModel]] = [:]

        sorted.forEach({
            let date = $0.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            
            dateChatsDicts[dateFormatter.string(from: date)] = []
        })

        dateChatsDicts.keys.forEach({ key in
            sorted.forEach({ model in
                if isSameDates(firstDate: key, secondDate: model.date) {
                    var buf: [ChatModel] = dateChatsDicts[key] ?? []
                    buf.append(model)
                    dateChatsDicts[key] = buf
                }
            })
        })

        dateChatsArray.removeAll()
        for key in dateChatsDicts.keys {
            dateChatsArray.append(dateChatsDicts[key] ?? [])
        }
        
        dateChatsArray = dateChatsArray.sorted(by: {
            return $0.first!.date > $1.first!.date
        })

        tableView.dateChatsArray = dateChatsArray
        
        tableView.reloadData()
    }
    
    private func isSameDates(firstDate: String, secondDate: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        return firstDate == dateFormatter.string(from: secondDate) ? true : false
    }
    
}
