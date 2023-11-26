import Foundation
import Flutter

@available(iOS 13, *)
class SignInWithAppleViewFactory : NSObject, FlutterPlatformViewFactory {
    let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return SignInWithAppleView(frame: frame, viewId: viewId, args: args, messenger: messenger)
    }
}
