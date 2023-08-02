import UIKit

final class SendButton: UIButton {
    let realmService = RealmService()
    weak var delegate: SendButtonDelegate?
    var message: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        isEnabled = false
        setBackgroundImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        tintColor = .systemGreen
        makeSystem(self)
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

@objc extension SendButton {
    func buttonAction() {
        delegate?.SendButtonTapped()
        
        SendMessage()
        self.isEnabled = false
    }
}

//MARK: - SEND MESSAGE TO CHATGPT API
extension SendButton {
    func regenerateResponce(at section: Int) {
        guard let delegate = delegate else { fatalError("nil delegate") }
        
        let message = delegate.responseList[section].request
        
        Task {
            do {
                if Settings.shared.messageMode == .full {
                    let text = try await Settings.shared.chatGptApi.sendMessage(message)
                    let chatBlock = ChatBlock(request: message, responce: text, isSucces: true)
                    delegate.responseList.append(chatBlock)
                    delegate.reloadCollectionView()
                    delegate.moveToLastCell()
                } else {
                    let stream = try await Settings.shared.chatGptApi.sendMessageStream(text: message)
                    let chatBlock = ChatBlock(request: message, responce: "", isSucces: true)
                    delegate.responseList.append(chatBlock)
                    delegate.moveToLastCell()
                    var text = ""
                    for try await line in stream {
                        text += line
                        delegate.responseList[delegate.responseList.count-1].responce = text
                        delegate.reloadCollectionView()
                        delegate.moveToLastCell()
                    }
                }
            } catch {
                let chatBlock = ChatBlock(request: message, responce: error.localizedDescription, isSucces: false)
                delegate.responseList.append(chatBlock)
                delegate.reloadCollectionView()
                delegate.moveToLastCell()
            }
        }
        
        delegate.responseList.remove(at: section)
        delegate.reloadCollectionView()
        delegate.moveToLastCell()
    }
    
    func SendMessage(isnewMessage: Bool = true) {
        guard let delegate = delegate else { fatalError("nil delegate") }
        
        Task {
            do {                
                let chatBlock = ChatBlock(request: message ?? "", responce: "", isSucces: true)
                delegate.responseList.append(chatBlock)
                delegate.reloadCollectionView()
                delegate.moveToLastCell()
                
                //Полное сообщение
                if Settings.shared.messageMode == .full {
                    let text = try await Settings.shared.chatGptApi.sendMessage(message!)
                    delegate.responseList[delegate.responseList.count-1] = ChatBlock(request: message ?? "", responce: text, isSucces: true)
                    delegate.reloadCollectionView()
                    delegate.moveToLastCell()
                } else {
                //Потоковое
                    let stream = try await Settings.shared.chatGptApi.sendMessageStream(text: message!)
                    delegate.responseList[delegate.responseList.count-1] = ChatBlock(request: message ?? "", responce: "", isSucces: true)
                    var text = ""
                    for try await line in stream {
                        text += line
                        delegate.responseList[delegate.responseList.count-1].responce = text
                        delegate.reloadCollectionView()
                        delegate.moveToLastCell()
                    }
                }
                
                message = ""
            } catch {
                delegate.responseList[delegate.responseList.count-1].responce = error.localizedDescription
                delegate.responseList[delegate.responseList.count-1].isSucces = false
                delegate.reloadCollectionView()
                delegate.moveToLastCell()
            }
        }
    }
}

