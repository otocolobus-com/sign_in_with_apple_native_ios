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
    let messenger: FlutterBinaryMessenger

    let methodChannel: FlutterMethodChannel

    init(frame: CGRect, viewId: Int64, args: Any?, messenger: FlutterBinaryMessenger) {
        self.frame = frame
        self.viewId = viewId
        self.args = args
        self.messenger = messenger
        
        self.methodChannel = FlutterMethodChannel(name: "SignInWithAppleNativeButton_\(viewId)", binaryMessenger: messenger)
    }

    func view() -> UIView {
        if #available(iOS 13, *) {
            let button = ASAuthorizationAppleIDButton(frame: frame)
            button.addTarget(self, action: #selector(onPressed), for: .touchUpInside)
            return button
        }

        return UIView()
    }

    @objc func onPressed() {
        methodChannel.invokeMethod("onPressed", arguments: nil)
    }
}
