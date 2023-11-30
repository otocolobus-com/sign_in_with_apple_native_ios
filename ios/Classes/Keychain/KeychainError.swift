import Foundation

enum KeychainError : Error {
    case unhandledError(status: OSStatus)
    case noItem
    case unexpectedData
}
