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
    private let imageView =  Avatar(avatarImage: UIImage(named: "openai-logo-svg")!)
    
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
            backgroundColor = .systemBlue
            label.text = "[user]\n\(text!)"
        
        case .assistant:
            backgroundColor = .systemGreen
            label.text = "[assistant]\n\(text!)"
        }
        
        isSuccess ? (self.label.textColor = .black) : (self.label.textColor = .red)
    }
}

extension MessageCell {
    
    private func configure() {
        layer.cornerRadius = 10
        
        addViews()
        layout()
    }
    
    private func addViews() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            //imageView
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 2),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            //label
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -2),
            label.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 2),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -2),
            
        ])
    }
    
}

extension MessageCell {
     private final class Avatar: UIImageView {
        convenience init(avatarImage: UIImage) {
            self.init(frame: .zero)
            configure()
            self.image = avatarImage
        }
        
         private func configure() {
            contentMode = .scaleAspectFit
            translatesAutoresizingMaskIntoConstraints = false
             tintColor = .white
        }
    }
}
