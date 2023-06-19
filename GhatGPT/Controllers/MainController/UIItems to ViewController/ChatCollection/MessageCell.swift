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
    
    public func setupCell(text: String?,author: Resorces.Authors) {
        self.author = author
        
        switch author {
        case .user:
            backgroundColor = .systemBlue
            label.text = "[user] \(text!)"
        
        case .assistant:
            backgroundColor = .systemGreen
            label.text = "[assistant] \(text!)"
        }
        
    }
}

extension MessageCell {
    
    private func configure() {
        
        
        
        addViews()
        layout()
    }
    
    private func addViews() {
        contentView.addSubview(label)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
}
