//
//  HistoryTableView.swift
//  GPTQuery
//
//  Created by Николай Прощалыкин on 17.07.2023.
//

import UIKit

final class HistoryTableView: UITableView {
    
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
        3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
        
        
        cell.setupCell()
        return cell
    }
    
//MARK: - Delegate
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Date"
    }
}
