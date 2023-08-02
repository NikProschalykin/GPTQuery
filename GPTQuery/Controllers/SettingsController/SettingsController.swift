import UIKit

final class SettingsController: BaseController {
    //MARK: - PROPERTIES
    
    private let titleLabel = TitleLabel()
    private let displayBlock = DisplayBlock()
    let apiKeyBlock = ApiKeyBlock()
    private let displayBlockDescriptionLabel = DescriptionLabel(text: Resorces.Strings.SettinsStrings.SettingsDescriptions.streamModeBlock)
    private let apiKeyBlockDescriptionLabel = DescriptionLabel(text: Resorces.Strings.SettinsStrings.SettingsDescriptions.apiKeyBlock)
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - ADD VIEWS
    override func addViews() {
        super.addViews()
        [titleLabel,displayBlock, apiKeyBlock, displayBlockDescriptionLabel, apiKeyBlockDescriptionLabel].forEach({ view.addSubview($0) })
    }
    
    //MARK: - CONFIGURE
    override func configure() {
        super.configure()
        apiKeyBlock.setupButton.delegate = self
    }
    
    //MARK: - LAYOUT
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            //displayMessageStack
            displayBlock.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            displayBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            displayBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            displayBlock.heightAnchor.constraint(equalToConstant: 40),
            
            //displayBlockDescriptionLabel
            displayBlockDescriptionLabel.topAnchor.constraint(equalTo: displayBlock.bottomAnchor, constant: 8),
            displayBlockDescriptionLabel.leadingAnchor.constraint(equalTo: displayBlock.leadingAnchor, constant: 16),
            displayBlockDescriptionLabel.trailingAnchor.constraint(equalTo: displayBlock.trailingAnchor,constant: -16),

            //apiKeyBlock
            apiKeyBlock.leadingAnchor.constraint(equalTo: displayBlock.leadingAnchor),
            apiKeyBlock.trailingAnchor.constraint(equalTo: displayBlock.trailingAnchor),
            apiKeyBlock.heightAnchor.constraint(equalToConstant: 150),
            apiKeyBlock.topAnchor.constraint(equalTo: displayBlockDescriptionLabel.bottomAnchor, constant: 50),
            
            //apiKeyBlockDescriptionLabel
            apiKeyBlockDescriptionLabel.topAnchor.constraint(equalTo: apiKeyBlock.bottomAnchor, constant: 8),
            apiKeyBlockDescriptionLabel.leadingAnchor.constraint(equalTo: apiKeyBlock.leadingAnchor, constant: 16),
            apiKeyBlockDescriptionLabel.trailingAnchor.constraint(equalTo: apiKeyBlock.trailingAnchor,constant: -16),
        ])
    }
}

//MARK: - SetupButtonDelegate
extension SettingsController: SetupKeyButtonDelegate {
   // ...
}

//MARK: - TitleLabel
extension SettingsController {
    final class TitleLabel: UILabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configure() {
            text = Resorces.Strings.SettinsStrings.SettingsDescriptionsRawStrings.Title
            font = Resorces.Font.helveticaBold(with: 24)
            translatesAutoresizingMaskIntoConstraints = false
            textColor = Resorces.Colors.titleSecondaryLabel
            textAlignment = .center
        }
    }
}
