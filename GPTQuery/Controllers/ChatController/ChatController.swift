import UIKit

final class ChatController: BaseController {
    
//MARK: - realm properties
    var realmServise = RealmService()
    var currChatModel: ChatModel?
    
//MARK: - Layout properties
    var heightFooter = NSLayoutConstraint()
    
//MARK: - PROPERTIES
    var responseList = [ChatBlock]()
    
    private let notificationCenter = NotificationCenter.default
    
    private let contentView = BaseView()
    private let scrollView = ViewControllerScrollView()
    private lazy var footer = MainFooter()
    private let startLabel = StartMessage()
    private let layout = ChatCollectionLayout()
    private lazy var collectionView = ChatCollection(frame: .zero, collectionViewLayout: layout)
    
//MARK: - GESTURES
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    
//MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyBoardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//MARK: - ViewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        moveToLastCell(animated: false)
    }
    
//MARK: - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveToLastCell(animated: true)
    }
    
//MARK: - ViewWillDissappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateRealmBeforeLeaveVC()
    }
    
//MARK: - ViewDidDissappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRealmToController()
    }
    
//MARK: - CONFIGURE
    override func configure() {
        super.configure()
        footer.sendButton.delegate = self
        footer.textView.delegate = self
        collectionView.VCdelegate = self
        
        title = setupTitle()
        (currChatModel != nil) ? (startLabel.isHidden = true) : (startLabel.isHidden = false)
        addNavBarButton(at: .right, with: nil, with: "clear")
    }
    
//MARK: - ADD VIEWS
    override func addViews() {
        super.addViews()
        view.addGestureRecognizer(tapGesture)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [footer, collectionView, startLabel].forEach({ contentView.addSubview($0) })
    }
    
//MARK: - LAYOUT
    override func layoutViews() {
        super.layoutViews()
        heightFooter = footer.heightAnchor.constraint(equalToConstant: 45)
    
        NSLayoutConstraint.activate([
            //scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          
            //contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            //collectionView
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: footer.topAnchor, constant: -8),
            
            //startLabel
            startLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 100),
            startLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 50),
            startLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -50),
            startLabel.bottomAnchor.constraint(equalTo: footer.topAnchor,constant: -50),
            
            //footer
            footer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            heightFooter,
            ])
    }
}

//MARK: - extension
@objc extension ChatController {
    
    //MARK: - keyBoardShow
    private func keyBoardShow(notification: NSNotification){
        if let keyBoardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.setContentOffset(CGPoint(x: 0, y: keyBoardSize.height), animated: true)
        }
    }
    
    //MARK: - keyBoardHide
    private func keyBoardHide() {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    //MARK: - hideKeyBoard
    public func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - TextViewDelegate
extension ChatController: UITextViewDelegate {
    // Ввод текста + увеличение TextView от контента
    func textViewDidChange(_ textView: UITextView) {
        writeMessage(textView)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        hidePlaceHolder(textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       showPlaceHolder(textView)
    }
}

//MARK: - SendButtonDelegate
extension ChatController: SendButtonDelegate {
    func SendButtonTapped() {
        heightFooter.constant = 45
        hideKeyboard()
        footer.textView.text = Resorces.Strings.ChatStrings.textViewPlaceHolder
        footer.textView.textColor = UIColor.lightGray
        startLabel.isHidden = true
    }
    
    func moveToLastCell(animated: Bool = false) {
        collectionView.scrollToBottom(animated: animated)
    }
    
    func reloadCollectionView() {
       collectionView.reloadData()
   }
}

//MARK: - ChatCollectionDelegate
extension ChatController: ChatCollectionDelegate {
    // ...
}

//MARK: -  Установка заголовка
extension ChatController {
    private func setupTitle() -> String {
        guard let date = currChatModel?.date else { return "Today" }
        
        return date.getIntervalFromToCurrentDate(date: date)
    }
}

//MARK: - Очистка чата
extension ChatController {
    override func navBarRightButtonHandler() {
        guard !responseList.isEmpty else { return }
        Settings.shared.chatGptApi.deleteHistoryList()
        responseList.removeAll()
        collectionView.reloadData()
    }
}

 //MARK: - RegenerateResponce
extension ChatController {
    func regenerateResponse(at section: Int) {
        self.footer.sendButton.regenerateResponce(at: section)
    }
}

//MARK: - ViewController lifecycle with realm
extension ChatController {
    private func setupRealmToController() {
        if let currChatModel = currChatModel {
            for message in currChatModel.messages {
                let chatBlock = ChatBlock(request: message.request,
                                          responce: message.response,
                                          isSucces: message.isSuccess)
                responseList.append(chatBlock)
            }
        } else {
            currChatModel = ChatModel()
        }
    }
    
    private func updateRealmBeforeLeaveVC() {
        guard let currChatModel = currChatModel  else { return }
        
        let isChatChanges = currChatModel.messages.count < responseList.count ? true : false
        
        try? realmServise.localRealm.write {
            currChatModel.messages.removeAll()
            
            for chatBlock in responseList {
                let message = ChatMessage()
                message.request = chatBlock.request
                message.response = chatBlock.responce
                message.isSuccess = chatBlock.isSucces
                currChatModel.messages.append(message)
            }
            
            if isChatChanges { currChatModel.date = Date() }
            realmServise.localRealm.add(currChatModel,update: .all)
           
            guard !responseList.isEmpty else {
                realmServise.localRealm.delete(currChatModel.self)
                return
            }
        }
    }
}

//MARK: - Custom placeHolder for textView
extension ChatController {
    private func hidePlaceHolder(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = Resorces.Colors.titleLabel
        }
    }
    
    private func showPlaceHolder(_ textView: UITextView) {
        textView.text.isBlank ? (footer.sendButton.isEnabled = false) : (footer.sendButton.isEnabled = true)
        if textView.text.isEmpty {
            textView.text = Resorces.Strings.ChatStrings.textViewPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: - Ввод текста + увеличение TextView от контента
extension ChatController {
    private func writeMessage(_ textView: UITextView) {
        footer.sendButton.message = textView.text
        
        !textView.text.isBlank ? (footer.sendButton.isEnabled = true) : (footer.sendButton.isEnabled = false)
        
        switch textView.contentSize.height {
        case 56..<388:
            heightFooter.constant = textView.contentSize.height + 8
        case 388...:
            heightFooter.constant = 388
        default:
            heightFooter.constant = 45
        }
        
        view.layoutIfNeeded()
    }
}


