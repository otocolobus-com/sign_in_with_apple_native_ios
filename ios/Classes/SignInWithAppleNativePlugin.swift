import Flutter
import UIKit

public class SignInWithAppleNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "SignInWithAppleNative", binaryMessenger: registrar.messenger())
    let instance = SignInWithAppleNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let viewFactory = SignInWithAppleViewFactory.init(messenger: registrar.messenger())
    registrar.register(viewFactory, withId: "SignInWithAppleNativeButton")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "isAvailable":
        if #available(iOS 13, *) {
            result(true)
            return
        }

        result(false)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
