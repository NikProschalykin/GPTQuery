//
//  KeyChainManager.swift
//  GPTQuery
//
//  Created by Николай Прощалыкин on 24.07.2023.
//

import Foundation

//MARK: - protocol KeyChainManagerProtocol
protocol KeyChainManagerProtocol {
    
    static func save(token: Data, account: String) throws -> String
    static func getToken(for account: String) throws -> Data?
    static func updateToken(token: Data,for account: String) throws -> String
    static func deleteToken(token: Data, account: String) throws -> String
}


//MARK: - Error enum
enum KeyChainError: Error {
    case duplicateItem
    case unknown(status: OSStatus)
}


//MARK: - class KeyChainManager
final class KeyChainManager: KeyChainManagerProtocol {
    
    static func save(token: Data, account: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: token
        ]
        
        let status = SecItemAdd(query as CFDictionary , nil )
        
        guard status != errSecDuplicateItem else {
            throw KeyChainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status: status)
        }
        
        return "Saved"
    }
    
    static func getToken(for account: String) throws -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status: status)
        }
        
        return result as? Data
    }
    
    static func updateToken(token: Data,for account: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
        ]
        
        let updateFields : [CFString: Any] = [
            kSecAttrAccount: account,
            kSecValueData: token
        ]
        
        let status = SecItemUpdate(query as CFDictionary, updateFields as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status: status)
        }
        
        return "Updated"
    }
    
    static func deleteToken(token: Data, account: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: token
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status: status)
        }
        
        return "Deleted"
    }
}
