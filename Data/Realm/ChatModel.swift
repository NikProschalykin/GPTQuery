import Foundation
import RealmSwift

final class ChatModel: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var date = Date()
    @Persisted var messages = List<ChatMessage>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

final class ChatMessage: Object {
    @Persisted var request: String = ""
    @Persisted var response: String = ""
    @Persisted var isSuccess: Bool = true
}
