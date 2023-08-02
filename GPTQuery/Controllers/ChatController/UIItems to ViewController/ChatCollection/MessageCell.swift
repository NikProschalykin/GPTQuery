import UIKit

final class MessageCell: UICollectionViewCell {
    private let contentCellView = BaseView()
    private let textView = MessageTextView()
    private var author: Resorces.Authors?
    private let imageView = Avatar(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
    }
    
    public func setupCell(text: String?,author: Resorces.Authors,  isSuccess: Bool) {
        self.author = author
        
        switch author {
        case .user:
            backgroundColor = Resorces.Colors.userMessageCell
            textView.text = "\(text!)"
            imageView.image = Resorces.Images.avatarManClearSvg
        
        case .assistant:
            backgroundColor = Resorces.Colors.aiMessageCell
            textView.text = "\(text!)"
            imageView.image = Resorces.Images.logoSvg
        }
        
       isSuccess ? (self.textView.textColor = Resorces.Colors.messageText) : (self.textView.textColor = Resorces.Colors.errorText)
    }
}

extension MessageCell {
    private func configure() {
        layer.cornerRadius = 10
        addViews()
        layout()
    }
    
    private func addViews() {
        [textView,imageView].forEach({ self.contentView.addSubview($0) })
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            //imageView
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 2),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            //label
            textView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 8),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -4),
            textView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -2),
            
        ])
    }
}


//MARK: - Avatar imageView
extension MessageCell {
     private final class Avatar: UIImageView {
         override init(frame: CGRect) {
             super.init(frame: frame)
             configure()
         }
         
         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
         
         private func configure() {
            contentMode = .scaleAspectFit
            translatesAutoresizingMaskIntoConstraints = false
            tintColor = Resorces.Colors.avatar
        }
    }
}


