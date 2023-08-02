import UIKit

final class SendTypeSwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SendTypeSwitch {
    private func configure() {
        (Settings.shared.messageMode == .stream) ? (isOn = true) : (isOn = false)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
    }
}

@objc extension SendTypeSwitch {
    func switchAction(sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        
        if sender.isOn {
            Settings.shared.messageMode = .stream
            userDefaults.set(Mode.stream.rawValue, forKey: "messageMode")
        } else {
            Settings.shared.messageMode = .full
            userDefaults.set(Mode.full.rawValue, forKey: "messageMode")
        }
    }
}
