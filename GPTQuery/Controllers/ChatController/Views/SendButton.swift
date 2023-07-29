//
//  SendButton.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

final class SendButton: UIButton {
    
    let realmService = RealmService()
    weak public var parentChatController: ChatController?
    private var message: String?
    
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
        print("tapped")
        parentChatController?.heightFooter.constant = 45
        parentChatController?.hideKeyboard()
        parentChatController?.deleteTextInTextView()
        parentChatController?.hideStartLabel()
            
        SendMessage()
        self.isEnabled = false
    }
}

//MARK: - Ввод текста + увеличение TextView от контента
extension SendButton: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        message = textView.text

        !textView.text.isBlank ? (self.isEnabled = true) : (self.isEnabled = false)
        
        switch textView.contentSize.height {
        case 56..<388:
            parentChatController?.heightFooter.constant = textView.contentSize.height + 8
        case 388...:
            parentChatController?.heightFooter.constant = 388
        default:
            parentChatController?.heightFooter.constant = 45
        }
        
        //print(textView.contentSize.height)
        parentChatController?.view.layoutIfNeeded()
    }
}

//MARK: - CustomPlaceHolder
extension SendButton {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = Resorces.Colors.titleLabel
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text.isBlank ? (self.isEnabled = false) : (self.isEnabled = true)
        if textView.text.isEmpty {
            textView.text = Resorces.Strings.ChatStrings.textViewPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: - SEND MESSAGE TO Server
extension SendButton {
        
    func SendMessage(isnewMessage: Bool = true) {
        guard let parentChatController = parentChatController else { fatalError("nil vc") }
        
        Task {
            do {
                isnewMessage ? parentChatController.responseList.append((message!,"",true)) : (parentChatController.responseList[parentChatController.responseList.count-1] = (message!,"", true))
                parentChatController.reloadColectionView()
                parentChatController.moveToLastCell()
                
                //Полное сообщение
                if Settings.shared.messageMode == .full {
                    let text = try await Settings.shared.chatGptApi.sendMessage(message!)
                    print(text)
                    parentChatController.responseList[parentChatController.responseList.count-1] = (message!,text, true)
                    parentChatController.reloadColectionView()
                    parentChatController.moveToLastCell()
                } else {
                //Потоковое
                    let stream = try await Settings.shared.chatGptApi.sendMessageStream(text: message!)
                    parentChatController.responseList[parentChatController.responseList.count-1] = (message!,"",true)
                    parentChatController.moveToLastCell()
                    var text = ""
                    for try await line in stream {
                        print(line,terminator: "")
                        text += line
                        parentChatController.responseList[parentChatController.responseList.count-1] = (message!,text, true)
                        parentChatController.reloadColectionView()
                    }
                }
                message = ""
            } catch {
                parentChatController.responseList[parentChatController.responseList.count-1] = (message!,error.localizedDescription, false)
                parentChatController.reloadColectionView()
                parentChatController.moveToLastCell()
            }
//            guard let chat = parentChatController.currChatModel else { return }
//
//            try? realmService.localRealm.write {
//
//                chat.messages.removeAll()
//                for tuple in parentChatController.responseList {
//                    let message = ChatMessage()
//                    message.request = tuple.0
//                    message.response = tuple.1
//                    message.isSuccess = tuple.2
//                    chat.messages.append(message)
//                }
//
//                chat.date = Date()
//                realmService.localRealm.add(chat,update: .all)
//
//               //realmService.localRealm.deleteAll()
//            }
        }
    }
}

