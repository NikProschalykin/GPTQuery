import UIKit

final class KeyLabel: UILabel {
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(showHideKey))
    private var isTextHide = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension KeyLabel {
    private func configure() {
        textColor = Resorces.Colors.titleLabel
        text = "***********************"
        translatesAutoresizingMaskIntoConstraints = false
        font = Resorces.Font.helveticaRegular(with: 40)
        numberOfLines = 1
        isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
}

@objc extension KeyLabel {
    private func showHideKey() {
        if isTextHide {
            font = Resorces.Font.helveticaRegular(with: 13)
            text = Settings.shared.apiKey
            isTextHide = false
        } else {
            font = Resorces.Font.helveticaRegular(with: 40)
            text = "***********************"
            isTextHide = true
        }
    }
}
