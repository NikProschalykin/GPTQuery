import UIKit

final class HistoryTableView: UITableView {
    
    var dateChatsArray: [[ChatModel]] = []
    let realmServise = RealmService()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        separatorInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
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
        return date.getIntervalFromToCurrentDate(date: date)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatController()
        
        vc.currChatModel = dateChatsArray[indexPath.section][indexPath.row]
        
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Delete") { [weak self] (action, view, completionHandler) in self?.handleDeleteChat(at: indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//MARK: - Swipe handlers
extension HistoryTableView {
    private func handleDeleteChat(at indexPath: IndexPath) {
        try? realmServise.localRealm.write {
            realmServise.localRealm.delete(dateChatsArray[indexPath.section][indexPath.row.self])
        }
        let range = NSMakeRange(0, self.numberOfSections)
        let indexSet = NSIndexSet(indexesIn: range)
        self.reloadSections(indexSet as IndexSet, with: UITableView.RowAnimation.automatic)
    }
}
