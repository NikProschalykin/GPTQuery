import UIKit

final class ChatCell: UITableViewCell {
    
//MARK: - Properties
    
    //timeLabel
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.font = Resorces.Font.helveticaRegular(with: 12)
        label.textColor = Resorces.Colors.titleSecondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //lastResponceLabel
    private lazy var lastResponceLabel: UILabel = {
        let label = UILabel()
        
        label.font = Resorces.Font.helveticaRegular(with: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        lastResponceLabel.text = nil
    }
    
    //MARK: - setupCell
    func setupCell(model: ChatModel) {
        timeLabel.text = getTime(date: model.date)
        lastResponceLabel.attributedText = getText(text: model.messages.last?.request)
    }
}

extension ChatCell {
    private func configure() {
        layer.cornerRadius = 50
        addViews()
        layout()
    }
    
    private func addViews() {
        [timeLabel, lastResponceLabel].forEach({ contentView.addSubview($0) })
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            //timeLabel
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            //lastResponceLabel
            lastResponceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            lastResponceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            lastResponceLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -4),
            lastResponceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        ])
    }
}

//MARK: - only time from date
extension ChatCell {
    private func getTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

//MARK: - confugured text to lastResponce
extension ChatCell {
    private func getText(text: String?) -> NSMutableAttributedString {
        let responceText: NSMutableAttributedString = {
            let string = "Last Responce:\n" + (text ?? "")
            let text = NSMutableAttributedString(string: string)
            
            let rangeGrayText = NSString(string: string).range(of: "Last Responce:",options: String.CompareOptions.caseInsensitive)
            
            text.addAttributes([.foregroundColor: Resorces.Colors.titleSecondaryLabel,
                                .font: Resorces.Font.helveticaRegular(with: 12)],
                               range: rangeGrayText)
        
            return text
        }()
        return responceText
    }
}
