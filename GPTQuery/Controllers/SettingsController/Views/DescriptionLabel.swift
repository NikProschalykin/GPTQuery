import UIKit

final class DescriptionLabel: UILabel {
    convenience init(text: NSMutableAttributedString){
        self.init(frame: .zero)
        self.attributedText = text
        configure()
    }
}

extension DescriptionLabel {
    private func configure() {
        textAlignment = .center
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
