//
//  ChatGPTModel.swift
//  GhatGPT
//
//  Created by Николай Прощалыкин on 14.06.2023.
//

import Foundation


//MARK: -  chatGPT-3.5-turbo-model

struct Message: Codable {
    let role: String
    let content: String
}

extension Array where Element == Message {
    var contentCount: Int { reduce(0, { $0 + $1.content.count } ) }
}

struct Request: Codable {
    let model: String
    let temperature: Double
    let messages: [Message]
    let stream: Bool
}

struct ErrorRootResponse: Decodable {
    let error: ErrorResponse
}

struct ErrorResponse: Decodable {
    let message: String
    let type: String?
}

struct StreamCompletionResponse: Decodable {
    let choices: [StreamChoice]
}

struct CompletionResponce: Decodable {
    let choices: [Choice]
    let usage: Usage?
}

struct Usage: Decodable {
    let promptTokens: Int?
    let completionTokens: Int?
    let totalTokens: Int?
}

struct Choice: Decodable {
    let message: Message
    let finishReason: String?
}

struct StreamChoice: Decodable {
    let finishReason: String?
    let delta: StreamMessage
}

struct StreamMessage: Decodable {
    let content: String?
    let role: String?
}
