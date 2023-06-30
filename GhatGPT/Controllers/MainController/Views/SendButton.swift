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
            
        Settings.shared.messageMode == .full ? SendFullMessage() : SendStreamMessage()
//            do {
//                        //потоковый
////                let stream = try await api.sendMessageStream(text: message!)
////                ChatController.responseList.append((message!,""))
////                chatVC?.moveToLastCell()
////                var text = ""
////                for try await line in stream {
////                    print(line,terminator: "")
////                    text += line
////                    ChatController.responseList[ChatController.responseList.count-1] = (message!,text)
////                    chatVC?.reloadColectionView()
////                }
//
//
//                //непотоковый
//                let text = try await Settings.shared.chatGptApi.sendMessage(message!)
//                print(text)
//                chatVC?.deleteTextInTextView()
//                ChatController.responseList.append((message!,text))
//                chatVC?.reloadColectionView()
//                chatVC?.moveToLastCell()
//
//                message = ""
//            } catch {
//                print(error.localizedDescription)
//            }
        self.isEnabled = false
    }
}

//MARK: - Ввод текста + увеличение TextView от контента
extension SendButton: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        message = textView.text

        !textView.text.isBlank ? (self.isEnabled = true) : (self.isEnabled = false)
        //print(textView.text.isBlank)
        
        switch textView.contentSize.height {
        case 56..<388:
            chatVC?.heightFooter.constant = textView.contentSize.height
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


extension SendButton {
    //Потоковая
    private func SendStreamMessage() {
        Task {
            do {
                ChatController.responseList.append((message!,""))
                chatVC?.reloadColectionView()
                let stream = try await Settings.shared.chatGptApi.sendMessageStream(text: message!)
                ChatController.responseList[ChatController.responseList.count-1] = (message!,"")
                chatVC?.moveToLastCell()
                var text = ""
                for try await line in stream {
                    print(line,terminator: "")
                    text += line
                    ChatController.responseList[ChatController.responseList.count-1] = (message!,text)
                    chatVC?.reloadColectionView()
                }
                message = ""
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //Полная
    private func SendFullMessage() {
        Task {
            do {
                ChatController.responseList.append((message!,""))
                chatVC?.reloadColectionView()
                chatVC?.moveToLastCell()
                let text = try await Settings.shared.chatGptApi.sendMessage(message!)
                print(text)
                chatVC?.deleteTextInTextView()
                ChatController.responseList[ChatController.responseList.count-1] = (message!,text)
                chatVC?.reloadColectionView()
                chatVC?.moveToLastCell()
                message = ""
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
