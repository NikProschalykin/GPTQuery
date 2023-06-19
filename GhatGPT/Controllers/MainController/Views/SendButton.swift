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
        setBackgroundImage(UIImage(systemName: "paperplane"), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        tintColor = .systemGreen
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}
@objc extension SendButton {
    func buttonAction() {
        print("tapped")
        chatVC?.hideKeyboard()
        chatVC?.deleteTextInTextView()
        chatVC?.hideStartLabel()
        Task {
            let api = ChatAPI(apiKey: ChatController.apiKey)
            do {
                        //потоковый
                let stream = try await api.sendMessageStream(text: message!)
                ChatController.responseList.append((message!,""))
                chatVC?.moveToLastCell()
                var text = ""
                for try await line in stream {
                    print(line)
                    text += line
                    ChatController.responseList[ChatController.responseList.count-1] = (message!,text)
                    chatVC?.reloadColectionView()
                }
                

                //непотоковый
//                let text = try await api.sendMessage(message!)
//                print(text)
//                chatVC?.deleteTextInTextView()
//                ChatController.responseList.append((message!,text))
//                chatVC?.reloadColectionView()
                chatVC?.moveToLastCell()
                message = ""
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Ввод текста + увеличение TextView от контента
extension SendButton: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.text.count > 1 else { return }
        message = textView.text!
        print(textView.contentSize.height)
        if textView.contentSize.height > 40 { chatVC?.heightFooter.constant = textView.contentSize.height }
        else { chatVC?.heightFooter.constant = 40 }
        chatVC?.view.layoutIfNeeded()
    }
}

//MARK: - CustomPlaceHolder
extension SendButton {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
    }
}
