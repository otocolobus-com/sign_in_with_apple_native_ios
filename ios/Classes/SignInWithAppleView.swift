//
//  SignInWithAppleView.swift
//  sign_in_with_apple_native
//
//  Created by Władysław Czyżewski on 25.11.2023.
//

import Foundation
import Flutter
import AuthenticationServices

class SignInWithAppleView : NSObject, FlutterPlatformView, ASAuthorizationControllerDelegate {
    let frame: CGRect
    let viewId: Int64
    let args: Any?

    init(frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.args = args
    }
    
    func view() -> UIView {
        if #available(iOS 13, *) {
            return ASAuthorizationAppleIDButton(frame: frame)
        }
        
        return UIView()
    }
}
