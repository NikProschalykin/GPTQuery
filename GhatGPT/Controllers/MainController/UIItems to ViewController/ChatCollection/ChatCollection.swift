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
        register(IdicatorFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: IdicatorFooter.identifier)
    }
    
    //MARK: - Расчет размера ячейки
    private func calculateSize(to indexPath: IndexPath) -> CGSize {
        var text: String = "\n"
        switch indexPath.item {
        case 0: text += ChatController.responseList[indexPath.section].0
        case 1: text += ChatController.responseList[indexPath.section].1
        default: break
        }
        
        let height = (text.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: Resorces.Font.helveticaRegular(with: 18)))
        
        
        switch indexPath.item {
        case 0:
            print(height + 28, text)
            return CGSize(width: UIScreen.main.bounds.width - 16, height: height + 28)
        case 1:
            print(height + 16, text)
            return CGSize(width: UIScreen.main.bounds.width - 16, height: height + 16)
        default: return .zero
        }
    }
    
    //MARK: - Расчет размера футера
    private func calculateFooterSize(to section: Int) -> CGSize {
        guard ChatController.responseList[section].1.isBlank else { return .zero }
        return CGSize(width: 50, height: 50)
    }
}


//MARK: - DATA SOURCE
extension ChatCollection: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        ChatController.responseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ChatController.responseList[section].1.isBlank ? 1 : 2
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionView.elementKindSectionFooter:
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IdicatorFooter.identifier, for: indexPath)
                
                return footerView
            default:
                assert(false, "Unexpected element kind")
            }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        calculateFooterSize(to: section)
    }
}


