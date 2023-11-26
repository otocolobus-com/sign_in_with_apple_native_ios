import 'sign_in_with_apple_native_platform_interface.dart';

class SignInWithAppleNative {
  Future<String?> getPlatformVersion() {
    return SignInWithAppleNativePlatform.instance.getPlatformVersion();
  }

  Future<bool> isAvailable() {
    return SignInWithAppleNativePlatform.instance.isAvailable();
  }

  Future<Map> authorize() {
    return SignInWithAppleNativePlatform.instance.authorize();
  }
}
