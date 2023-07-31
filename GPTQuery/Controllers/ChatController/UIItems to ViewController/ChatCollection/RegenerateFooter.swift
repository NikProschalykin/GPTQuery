import UIKit

//MARK: - regenerate responce button
final class RegenerateFooter: UICollectionReusableView {
    let button = UIButton(type: .system)
    let sendButton = SendButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegenerateFooter {
    private func configure() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Regenerate responce", for: .normal)
        makeSystem(button)
        button.titleLabel?.font = Resorces.Font.helveticaRegular(with: 20)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        addViews()
        layoutViews()
   }
    
    private func addViews() {
        addSubview(button)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

@objc extension RegenerateFooter {
    func buttonAction() {
        let vc = self.parentViewController as? ChatController
        vc?.regenerateResponse()
    }
}

