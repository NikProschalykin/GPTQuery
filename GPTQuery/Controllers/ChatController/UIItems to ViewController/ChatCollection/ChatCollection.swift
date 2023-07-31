import UIKit

final class ChatCollection: UICollectionView {
    weak var VCdelegate: ChatCollectionDelegate?
    
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
        register(RegenerateFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RegenerateFooter.identifier)
    }
    
    
    //MARK: - Расчет размера ячейки
    private func calculateSize(to indexPath: IndexPath) -> CGSize {
        guard let VCdelegate = VCdelegate else { fatalError("nil vc") }
        var text: String = ""
        switch indexPath.item {
        case 0: text += VCdelegate.responseList[indexPath.section].0
        case 1: text += VCdelegate.responseList[indexPath.section].1
        default: break
        }
        
        let height = calculateTextViewHeight(text: text, font: Resorces.Font.helveticaRegular(with: 17), width: UIScreen.main.bounds.width - 80) + 4
        let width = UIScreen.main.bounds.width - 16
        
        switch indexPath.item {
        case 0:
            return CGSize(width: width, height: height)
        case 1:
            return CGSize(width: width, height: height)
        default: return .zero
        }
    }
    
    private func calculateTextViewHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
            textView.font = font
            textView.text = text
            textView.sizeToFit()
        return textView.frame.height < 54 ? 54 : textView.frame.height
    }
    
    //MARK: - Расчет размера футера
    private func calculateFooterSize(to section: Int) -> CGSize {
        guard let VCdelegate = VCdelegate else { fatalError("nil vc") }
        if VCdelegate.responseList[section].1.isBlank { return CGSize(width: 50, height: 50) }
        if !VCdelegate.responseList[section].2 { return CGSize(width: 50, height: 50) }
        return .zero
    }
}

//MARK: - DATA SOURCE
extension ChatCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let VCdelegate = VCdelegate else { fatalError("nil vc") }
        return VCdelegate.responseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let VCdelegate = VCdelegate else { fatalError("nil vc") }
       return VCdelegate.responseList[section].1.isBlank ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let VCdelegate = VCdelegate else { fatalError("nil vc") }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        
        if indexPath.item == 0 {
            cell.setupCell(text: VCdelegate.responseList[indexPath.section].0, author: .user, isSuccess: true)
        } else {
            cell.setupCell(text: VCdelegate.responseList[indexPath.section].1, author: .assistant, isSuccess: VCdelegate.responseList[indexPath.section].2)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let VCdelegate = VCdelegate else { fatalError("nil vc") }
        
        switch kind {
            case UICollectionView.elementKindSectionFooter:
            if VCdelegate.responseList[indexPath.section].2 {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IdicatorFooter.identifier, for: indexPath)
                
                return footerView
            } else {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RegenerateFooter.identifier, for: indexPath)
                
                return footerView
            }
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


