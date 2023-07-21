//
//  ChatCell.swift
//  GPTQuery
//
//  Created by Николай Прощалыкин on 17.07.2023.
//

import UIKit

final class ChatCell: UITableViewCell {
    
//MARK: - Properties
    
    //timeLabel
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Time"
        label.font = Resorces.Font.helveticaRegular(with: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //lastResponceLabel
    private lazy var lastResponceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "last Responce: 1 line\n2line"
        label.font = Resorces.Font.helveticaRegular(with: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //code
    }
    
    func setupCell() {
        //code
    }
    
}

extension ChatCell {
    
    private func configure() {
        layer.cornerRadius = 50
        
        addViews()
        layout()
    }
    
    private func addViews() {
        [timeLabel, lastResponceLabel].forEach({ contentView.addSubview($0) })
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            //timeLabel
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            timeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            //lastResponceLabel
            lastResponceLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            lastResponceLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            lastResponceLabel.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            lastResponceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
        ])
    }
}

//MARK: - Views
extension ChatCell {
    
    
}
