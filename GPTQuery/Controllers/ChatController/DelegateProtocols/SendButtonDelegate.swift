import Foundation

protocol SendButtonDelegate: ChatController {
    func SendButtonTapped()
    func moveToLastCell()
    func reloadCollectionView()
}
