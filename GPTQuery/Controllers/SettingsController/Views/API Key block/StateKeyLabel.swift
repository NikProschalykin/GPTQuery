import UIKit

final class StateKeyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StateKeyLabel {
    private func configure() {
        textColor = Resorces.Colors.titleSecondaryLabel
        text = "API Key: "
        translatesAutoresizingMaskIntoConstraints = false
        font = Resorces.Font.helveticaRegular(with: 17)
        numberOfLines = 1
    }
}
