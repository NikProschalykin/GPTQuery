//
//  HistoryTableView.swift
//  GPTQuery
//
//  Created by Николай Прощалыкин on 17.07.2023.
//

import UIKit

final class HistoryTableView: UITableView {
    
    var dateChatsArray: [[ChatModel]] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)

    }
}

extension HistoryTableView: UITableViewDelegate, UITableViewDataSource {
    
//MARK: - DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dateChatsArray[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        dateChatsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
        
        
        cell.setupCell(model: dateChatsArray[indexPath.section][indexPath.row])
        return cell
    }
    
//MARK: - Delegate
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let date = dateChatsArray[section].first?.date else { return "unknown date" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatController()
        
        vc.currChatModel = dateChatsArray[indexPath.section][indexPath.row]
        
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
