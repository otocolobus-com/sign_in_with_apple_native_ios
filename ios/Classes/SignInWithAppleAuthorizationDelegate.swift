//
//  SignInWithAppleAuthorizationDelegate.swift
//  sign_in_with_apple_native
//
//  Created by Władysław Czyżewski on 25.11.2023.
//

import Foundation
import AuthenticationServices

@available(iOS 13, *)
class SignInWithAppleAuthorizationDelegate: NSObject, ASAuthorizationControllerDelegate {
    let callback: (_ authorizationResult: [String: Any]) -> Void

    init(callback: @escaping (_ authorizationResult: [String: Any]) -> Void) {
        self.callback = callback
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let authorizationResult = authorization.credential as? ASAuthorizationAppleIDCredential {
            callback(["credential": authorizationResult])
        }

        callback(["error": "Notauthorized"])
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        callback(["error": error.localizedDescription])
    }
}