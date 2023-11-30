import Foundation
import AuthenticationServices

class SignInWithAppleAuthorizationDelegate: NSObject, ASAuthorizationControllerDelegate {
    let callback: (_ authorizationResult: [String: Any]) -> Void

    init(callback: @escaping (_ authorizationResult: [String: Any]) -> Void) {
        self.callback = callback
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let authenticationResult = authorization.credential as? ASAuthorizationAppleIDCredential {
            do {
                try KeychainItem.add(name: "currentUserId", value: authenticationResult.user)
            } catch {
                callback([
                    "isSuccess": false,
                    "error": "Could not add item to keychain"
                ])
                return
            }

            callback([
                "isSuccess": true,
                "credential": [
                    "id": authenticationResult.user,
                    "idToken": authenticationResult.identityToken.map({ value in
                        return String(data: value, encoding: .utf8)
                    }) as Any,
                    "email": authenticationResult.email as Any,
                    "fullName": authenticationResult.fullName.map({ value in
                        return [
                            "givenName": value.givenName,
                            "familyName": value.familyName,
                            "namePrefix": value.namePrefix,
                            "nameSuffix": value.nameSuffix,
                            "middleName": value.middleName,
                            "description": value.description,
                            "nickname": value.nickname
                        ]
                    }) as Any,
                    "authorizedScopes": authenticationResult.authorizedScopes,
                    "authorizationCode": authenticationResult.authorizationCode.map({ value in
                        return String(data: value, encoding: .utf8)
                    }) as Any
                ]
            ])
            return
        }

        callback([
            "isSuccess": false,
            "error": "Notauthorized"
        ])
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        callback([
            "isSuccess": false,
            "error": error.localizedDescription
        ])
    }
}
