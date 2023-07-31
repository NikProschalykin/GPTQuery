import UIKit

final class StartMessage: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StartMessage {
    private func configure() {
        textColor = Resorces.Colors.titleSecondaryLabel
        text = Resorces.Strings.ChatStrings.startMessage
        translatesAutoresizingMaskIntoConstraints = false
        font = Resorces.Font.helveticaRegular(with: 20)
        numberOfLines = 0
    }
}

