import Flutter
import UIKit
import AuthenticationServices

public class SignInWithAppleNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "SignInWithAppleNative", binaryMessenger: registrar.messenger())
    let instance = SignInWithAppleNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let revokedAuthenticationEventChannel = FlutterEventChannel(name: "SignInWithAppleNativeRevokedAuthentication", binaryMessenger: registrar.messenger())
    let authenticationStateListenerInstance = SignInWithAppleNotificationListener()
    revokedAuthenticationEventChannel.setStreamHandler(authenticationStateListenerInstance)

    let viewFactory = SignInWithAppleViewFactory.init(messenger: registrar.messenger())
    registrar.register(viewFactory, withId: "SignInWithAppleNativeButton")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isAvailable":
        result(true)
    case "authorize":
        guard let args = call.arguments as? [String: Any] else {
            result([
                "isSuccess": false,
                "error": "Invalid arguments"
            ])
            return
        }

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        if let requestedScopes = args["requestedScopes"] as? [String] {
            request.requestedScopes = requestedScopes.map({ value in
                return ASAuthorization.Scope(value)
            })
        }

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
    case "getState":
        let provider = ASAuthorizationAppleIDProvider()
        do {
            try provider.getCredentialState(forUserID: KeychainItem.currentUserId) { status, error in
                result(status.rawValue)
            }
        } catch {
            result(ASAuthorizationAppleIDProvider.CredentialState.notFound.rawValue)
        }
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
