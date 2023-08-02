import Foundation

protocol SendButtonDelegate: ChatController {
    func SendButtonTapped()
    func moveToLastCell(animated: Bool)
    func reloadCollectionView()
}
