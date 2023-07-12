//
//  MessageCell.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 16.06.2023.
//

import UIKit

final class MessageCell: UICollectionViewCell {
    
    
    private let contentCellView = BaseView()
    private let label = MessageLabel()
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
        label.text = nil
    }
    
    public func setupCell(text: String?,author: Resorces.Authors,  isSuccess: Bool) {
        self.author = author
        
        switch author {
        case .user:
            backgroundColor = Resorces.Colors.userMessageCell//.systemBlue
            label.text = "\(text!)"//[user]\n
            imageView.image = Resorces.Images.avatarManClearSvg
        
        case .assistant:
            backgroundColor = Resorces.Colors.aiMessageCell//.systemGreen
            label.text = "\(text!)"//[assistant]\n
            imageView.image = Resorces.Images.logoSvg
        }
        
       isSuccess ? (self.label.textColor = Resorces.Colors.messageText) : (self.label.textColor = Resorces.Colors.errorText)
    }
}

extension MessageCell {
    
    private func configure() {
        layer.cornerRadius = 10
        
        addViews()
        layout()
    }
    
    private func addViews() {
        [label,imageView].forEach({ self.contentView.addSubview($0) })
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            //imageView
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 2),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            //label
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -4),
            label.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -2),
            
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


