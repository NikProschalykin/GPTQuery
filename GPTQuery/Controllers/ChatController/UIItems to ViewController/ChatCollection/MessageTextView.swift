import UIKit

final class MessageTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageTextView {
    private func configure() {
        textColor = Resorces.Colors.messageText
        translatesAutoresizingMaskIntoConstraints = false
        font = Resorces.Font.helveticaRegular(with: 17)
        isEditable = false
        self.backgroundColor = nil
        isScrollEnabled = false
    }
}
