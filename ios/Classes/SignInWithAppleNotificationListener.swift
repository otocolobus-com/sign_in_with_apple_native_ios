import Foundation
import AuthenticationServices
import Flutter

class SignInWithAppleNotificationListener : NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        NotificationCenter.default.addObserver(self, selector: #selector(appleIdStateChanged), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(self)
        return nil
    }

    @objc func appleIdStateChanged() {
        guard eventSink != nil else {
            return
        }

        let provider = ASAuthorizationAppleIDProvider()
        do {
            try provider.getCredentialState(forUserID: KeychainItem.currentUserId) { state, error in
                do {
                    try KeychainItem.delete(name: "currentUserId")
                    self.eventSink!(state.rawValue)
                } catch {
                    // TODO: handle or log this exception?
                }
            }
        } catch {
            // TODO: handle or log this exception?
        }
    }
}
