import Foundation
import Security

struct KeychainItem {
    static var currentUserId: String {
        get throws {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: Bundle.main.bundleIdentifier as Any,
                kSecAttrAccount as String: "currentUserId",
                kSecMatchLimit as String: kSecMatchLimitOne,
                kSecReturnData as String: true
            ]

            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)
            guard status != errSecItemNotFound else { throw KeychainError.noItem }
            guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
            guard let itemData = item as? Data,
                  let itemValue = String(data: itemData, encoding: .utf8)
            else {
                throw KeychainError.unexpectedData
            }

            return itemValue
        }
    }
    
    static func add(name: String, value: String) throws {
        let item: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier as Any,
            kSecAttrAccount as String: name,
            kSecValueData as String: value.data(using: .utf8) as Any
        ]

        let status = SecItemAdd(item as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
}
