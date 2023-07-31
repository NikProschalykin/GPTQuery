import UIKit

// MARK: - VIEWCONTROLLER
final class ChatController: BaseController {
    
    //MARK: - realm properties
    var realmServise = RealmService()
    var currChatModel: ChatModel?
    
    //MARK: - Layout properties
    var heightFooter = NSLayoutConstraint()
    
    //MARK: - PROPERTIES
    var responseList = [(String,String,Bool)]()
    
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
        
        setupRealmToController()
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
        collectionView.parentChatController = self
    }
//MARK: - CONFIGURE
    override func configure() {
        super.configure()
        title = setupTitle()
        footer.sendButton.parentChatController = self
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

//MARK: -  Установка заголовка
extension ChatController {
    private func setupTitle() -> String {
        guard let date = currChatModel?.date else { return "Today" }
        
        return date.getIntervalFromToCurrentDate(date: date)
    }
}

//MARK: - Funcs for sendButton
extension ChatController {
    func reloadColectionView() {
        collectionView.reloadData()
    }
    
    func deleteTextInTextView() {
        footer.textView.text = Resorces.Strings.ChatStrings.textViewPlaceHolder
        footer.textView.textColor = UIColor.lightGray
    }
    
    func moveToLastCell() {
        collectionView.scrollToLast()
    }
    
    func hideStartLabel() {
        startLabel.isHidden = true
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

extension ChatController {
     func regenerateResponse() {
        self.footer.sendButton.SendMessage(isnewMessage: false)
    }
}

//MARK: - ViewController lifecycle with realm
extension ChatController {
    private func setupRealmToController() {
        if let currChatModel = currChatModel {
            for message in currChatModel.messages {
                responseList.append((message.request,
                                     message.response,
                                     message.isSuccess))
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
            
            for tuple in responseList {
                let message = ChatMessage()
                message.request = tuple.0
                message.response = tuple.1
                message.isSuccess = tuple.2
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



