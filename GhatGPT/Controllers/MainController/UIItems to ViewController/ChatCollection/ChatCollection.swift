//
//  ChatCollection.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 16.06.2023.
//

import UIKit

final class ChatCollection: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.identifier)
        dataSource = self
        delegate = self
    }
    
    //MARK: - Расчет размера ячейки
    private func calculateSize(to indexPath: IndexPath) -> CGSize {
        var text: String = ""
        switch indexPath.item {
        case 0: text = ChatController.responseList[indexPath.section].0
        case 1: text = ChatController.responseList[indexPath.section].1
        default: break
        }
        let height = (text.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: Resorces.Font.helveticaRegular(with: 17)))
        //print(height)
        return CGSize(width: UIScreen.main.bounds.width - 16, height: height + 32)
    }
}

//MARK: - DATA SOURCE
extension ChatCollection: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ChatController.responseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        
        if indexPath.item == 0 {
            cell.setupCell(text: ChatController.responseList[indexPath.section].0, author: .user)
        } else {
            cell.setupCell(text: ChatController.responseList[indexPath.section].1, author: .assistant)
        }
        
        return cell
    }
}

//MARK: - Delegate Flow Layout
extension ChatCollection: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateSize(to: indexPath)
    }
}


