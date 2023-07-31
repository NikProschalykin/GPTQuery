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
    func SendMessage(isnewMessage: Bool = true) {
        guard let delegate = delegate else { fatalError("nil vc") }
        
        Task {
            do {
                isnewMessage ? delegate.responseList.append((message!,"",true)) : (delegate.responseList[delegate.responseList.count-1] = (message!,"", true))
                delegate.reloadCollectionView()
                delegate.moveToLastCell()
                
                //Полное сообщение
                if Settings.shared.messageMode == .full {
                    let text = try await Settings.shared.chatGptApi.sendMessage(message!)
                    print(text)
                    delegate.responseList[delegate.responseList.count-1] = (message!,text, true)
                    delegate.reloadCollectionView()
                    delegate.moveToLastCell()
                } else {
                //Потоковое
                    let stream = try await Settings.shared.chatGptApi.sendMessageStream(text: message!)
                    delegate.responseList[delegate.responseList.count-1] = (message!,"",true)
                    delegate.moveToLastCell()
                    var text = ""
                    for try await line in stream {
                        print(line,terminator: "")
                        text += line
                        delegate.responseList[delegate.responseList.count-1] = (message!,text, true)
                        delegate.reloadCollectionView()
                    }
                }
                
                message = ""
            } catch {
                delegate.responseList[delegate.responseList.count-1] = (message!,error.localizedDescription, false)
                delegate.reloadCollectionView()
                delegate.moveToLastCell()
            }
        }
    }
}

