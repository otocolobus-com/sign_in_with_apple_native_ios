import 'package:sign_in_with_apple_native/sign_in_with_apple_native_authorization_result.dart';

import 'sign_in_with_apple_native_platform_interface.dart';

class SignInWithAppleNative {
  Future<bool> isAvailable() {
    return SignInWithAppleNativePlatform.instance.isAvailable();
  }

  Future<SignInWithAppleNativeAuthorizationResult> authorize() async {
    final result = await SignInWithAppleNativePlatform.instance.authorize();

    return SignInWithAppleNativeAuthorizationResult.fromMap(result);
  }
}
