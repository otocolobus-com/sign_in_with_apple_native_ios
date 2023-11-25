//
//  SingInWithAppleViewFactory.swift
//  sign_in_with_apple_native
//
//  Created by Władysław Czyżewski on 25.11.2023.
//

import Foundation
import Flutter

class SignInWithAppleViewFactory : NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return SignInWithAppleView(frame: frame, viewId: viewId, args: args)
    }
}
