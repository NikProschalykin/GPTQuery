import Foundation

protocol ChatBlockProtocol {
    var request: String { get set }
    var responce: String { get set }
    var isSucces: Bool { get set }
}

struct ChatBlock: ChatBlockProtocol {
    var request: String
    var responce: String
    var isSucces: Bool
}
