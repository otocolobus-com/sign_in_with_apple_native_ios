import Flutter
import UIKit
import AuthenticationServices

public class SignInWithAppleNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "SignInWithAppleNative", binaryMessenger: registrar.messenger())
    let instance = SignInWithAppleNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    if #available(iOS 13, *) {
        let viewFactory = SignInWithAppleViewFactory.init(messenger: registrar.messenger())
        registrar.register(viewFactory, withId: "SignInWithAppleNativeButton")
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isAvailable":
        if #available(iOS 13, *) {
            result(true)
            return
        }

        result(false)
    case "authorize":
        if #available(iOS 13, *) {
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            request.requestedScopes = []
            let controller = ASAuthorizationController(authorizationRequests: [request])
            var delegate: ASAuthorizationControllerDelegate?
            delegate = SignInWithAppleAuthorizationDelegate(
                callback: {payload in
                    result(payload)
                    delegate = nil
                }
            )
            controller.delegate = delegate
            controller.performRequests()
        } else {
            result(FlutterMethodNotImplemented)
        }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
