//
//  SendButton.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 15.06.2023.
//

import UIKit

final class SendButton: UIButton {
    
    weak public var chatVC: ChatController?
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
        chatVC?.heightFooter.constant = 45
        chatVC?.hideKeyboard()
        chatVC?.deleteTextInTextView()
        chatVC?.hideStartLabel()
            
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
            chatVC?.heightFooter.constant = textView.contentSize.height + 8
        case 388...:
            chatVC?.heightFooter.constant = 388
        default:
            chatVC?.heightFooter.constant = 45
        }
        
        //print(textView.contentSize.height)
        chatVC?.view.layoutIfNeeded()
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
        Task {
            do {
                isnewMessage ? ChatController.responseList.append((message!,"",true)) : (ChatController.responseList[ChatController.responseList.count-1] = (message!,"", true))
                chatVC?.reloadColectionView()
                chatVC?.moveToLastCell()
                
                //Полное сообщение
                if Settings.shared.messageMode == .full {
                    let text = try await Settings.shared.chatGptApi.sendMessage(message!)
                    print(text)
                    ChatController.responseList[ChatController.responseList.count-1] = (message!,text, true)
                    chatVC?.reloadColectionView()
                    chatVC?.moveToLastCell()
                } else {
                //Потоковое
                    let stream = try await Settings.shared.chatGptApi.sendMessageStream(text: message!)
                    ChatController.responseList[ChatController.responseList.count-1] = (message!,"",true)
                    chatVC?.moveToLastCell()
                    var text = ""
                    for try await line in stream {
                        print(line,terminator: "")
                        text += line
                        ChatController.responseList[ChatController.responseList.count-1] = (message!,text, true)
                        chatVC?.reloadColectionView()
                    }
                }
                message = ""
            } catch {
                ChatController.responseList[ChatController.responseList.count-1] = (message!,error.localizedDescription, false)
                chatVC?.reloadColectionView()
                chatVC?.moveToLastCell()
            }
        }
    }
}

