import UIKit

final class ChatCollectionLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


